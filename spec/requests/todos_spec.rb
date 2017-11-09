require 'rails_helper'

RSpec.describe 'Todos', type: :request do
    let(:user) { create(:user) }
    let!(:todos) { create_list(:todo, 10, user: user) }
    let(:todo_id) { todos.first.id }

    describe 'GET #index' do
        before { get '/todos', headers: valid_headers }

        it 'returns HTTP success' do
            expect(response).to have_http_status(:success)
        end

        it 'returns the todos for the given user' do
            expect(json).not_to be_empty
            expect(json.size).to eq(10)
        end
    end

    describe 'GET #show' do
        before { get "/todos/#{todo_id}", headers: valid_headers }

        context 'when the record exists' do
            it 'returns HTTP success' do
                expect(response).to have_http_status(:success)
            end

            it 'returns the correct todo list' do
                expect(json['todo_id']).to eq(todo_id)
                expect(json['title']).to eq(todos.first.title)
                expect(json['category']).to eq(todos.first.category)
            end
        end

        context 'when the record does not exist' do
            let(:todo_id) { 100 }

            it 'returns HTTP not found' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(json['message']).to match("Couldn't find Todo")
            end
        end
    end

    describe 'POST #create' do
        let(:valid_todo_attributes) do
            attributes_for(:todo)
        end

        context 'when the request is valid' do
            before { post '/todos', params: valid_todo_attributes.to_json, headers: valid_headers }

            it 'creates a new todo list' do
                expect(response).to have_http_status(201)
            end

            it 'returns success message' do
                expect(json['message']).to match('To-do list created successfully')
            end

            it 'returns the created todo list' do
                expect(json['todo']).not_to be_nil
            end
        end

        context 'when the request is invalid' do
            before { post '/todos', params: {}, headers: valid_headers }
            let(:current_todo_count) { Todo.count }

            it 'returns http failure' do
                expect(response).to have_http_status(422)
            end

            it 'does not create a new todo list' do
                expect(Todo.count).to eq(current_todo_count)
            end

            it 'returns failure message' do
                expect(json['message']).to match('To-do list could not be created')
            end
        end
    end

    describe 'PUT #update' do
        let(:new_attributes) do
            {
                title: "New Title",
                category: "newcategory"
            }
        end

        let(:bad_new_attributes) do
            {
                title: "A",
                category: "a"
            }
        end

        context 'when the request is valid' do
            before { put "/todos/#{todo_id}", params: new_attributes.to_json, headers: valid_headers }

            it 'returns http success' do
                expect(response).to have_http_status(200)
            end

            it 'returns success message' do
                expect(json['message']).to match('To-do list updated successfully')
            end

            it 'updates todo list with expected attributes' do
                expect(json['todo']['title']).to eq(new_attributes[:title])
                expect(json['todo']['category']).to eq(new_attributes[:category])
            end
        end

        context 'when the request is invalid' do
            before { put "/todos/#{todo_id}", params: bad_new_attributes.to_json, headers: valid_headers }

            it 'returns http failure' do
                expect(response).to have_http_status(422)
            end

            it 'does not update the todo list' do
                expect(todos.first.title).to_not eq(new_attributes[:title])
                expect(todos.first.category).to_not eq(new_attributes[:category])
            end

            it 'returns failure message' do
                expect(json['message']).to match('An error occurred while trying to save the to-do list. Please try again.')
            end
        end
    end

    describe 'DELETE #destroy' do
        context 'when the request is valid' do
            before { delete "/todos/#{todo_id}", headers: valid_headers }

            it 'returns http success' do
                expect(response).to have_http_status(200)
            end

            it 'returns success message' do
                expect(json['message']).to match('To-do list removed successfully')
            end

            it 'deletes the user' do
                count = Todo.where({id: todo_id}).size
                expect(count).to eq 0
            end
        end

        context 'when the request is invalid' do
            before { delete "/todos/0", headers: valid_headers }

            it 'returns http not found' do
                expect(response).to have_http_status(404)
            end

            it 'returns record not found error' do
                expect(json['message']).to match("Couldn't find Todo with 'id'=")
            end
        end
    end
end
