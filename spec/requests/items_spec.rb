require 'rails_helper'

RSpec.describe 'Items', type: :request do
    let(:user) { create(:user) }
    let(:todo) { create(:todo, user: user) }
    let!(:items) { create_list(:item, 20, todo: todo) }
    let(:todo_id) { todo.id }
    let(:item_id) { items.first.id }

    describe 'POST #create' do
        let(:valid_item_attributes) do
            attributes_for(:item)
        end

        context 'when the request is valid' do
            before { post "/todos/#{todo_id}/items", params: valid_item_attributes.to_json, headers: valid_headers }

            it 'creates a new todo list item' do
                expect(response).to have_http_status(201)
            end

            it 'returns success message' do
                expect(json['message']).to match('To-do list item created successfully')
            end

            it 'returns the created todo list item' do
                expect(json['item']).not_to be_nil
            end
        end

        context 'when the request is invalid' do
            before { post "/todos/#{todo_id}/items", params: {}, headers: valid_headers }
            let(:current_item_count) { Item.count }

            it 'returns http failure' do
                expect(response).to have_http_status(422)
            end

            it 'does not create a new todo list item' do
                expect(Item.count).to eq(current_item_count)
            end

            it 'returns failure message' do
                expect(json['message']).to match('To-do list item could not be created')
            end
        end
    end

    describe 'PUT #update' do
        let(:new_attributes) do
            { name: "New Name" }
        end
        let(:bad_new_attributes) do
            { name: "A" }
        end

        context 'when the request is valid' do
            before { put "/todos/#{todo_id}/items/#{item_id}", params: new_attributes.to_json, headers: valid_headers }

            it 'returns http success' do
                expect(response).to have_http_status(200)
            end

            it 'returns success message' do
                expect(json['message']).to match('To-do list item updated successfully')
            end

            it 'updates todo list item with expected attributes' do
                expect(json['item']['name']).to eq(new_attributes[:name])
            end
        end

        context 'when the request is invalid' do
            before { put "/todos/#{todo_id}/items/#{item_id}", params: bad_new_attributes.to_json, headers: valid_headers }

            it 'returns http failure' do
                expect(response).to have_http_status(422)
            end

            it 'does not update the todo list item' do
                expect(items.first.name).to_not eq(bad_new_attributes[:name])
            end

            it 'returns failure message' do
                expect(json['message']).to match('An error occurred while trying to save the to-do list item. Please try again.')
            end
        end
    end

    describe 'DELETE #destroy' do
        context 'when the request is valid' do
            before { delete "/todos/#{todo_id}/items/#{item_id}", headers: valid_headers }

            it 'returns http success' do
                expect(response).to have_http_status(200)
            end

            it 'returns success message' do
                expect(json['message']).to match('To-do list item removed successfully')
            end

            it 'deletes the todo list item' do
                count = Item.where({id: item_id}).size
                expect(count).to eq 0
            end
        end

        context 'when the request is invalid' do
            before { delete "/todos/#{todo_id}/items/0", headers: valid_headers }

            it 'returns http not found' do
                expect(response).to have_http_status(404)
            end

            it 'returns record not found error' do
                expect(json['message']).to match("Couldn't find Item with 'id'=")
            end
        end
    end
end
