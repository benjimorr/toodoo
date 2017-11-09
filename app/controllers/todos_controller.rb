class TodosController < ApplicationController
    def index
        @todos = Todo.where({user: @current_user})
        json_response(@todos, :ok)
    end

    def show
        @todo = Todo.find(params[:id])
        response = {
            todo_id: @todo.id,
            title: @todo.title,
            category: @todo.category
        }
        json_response(response, :ok)
    end

    def create
        @todo = Todo.new(todo_params)
        @todo.user = @current_user

        if @todo.save
            response = { message: Message.todo_created, todo: @todo }
            json_response(response, :created)
        else
            response = { message: Message.todo_not_created, errors: @todo.errors }
            json_response(response, 422)
        end
    end

    def update
        @todo = Todo.find(params[:id])
        @todo.assign_attributes(todo_params)

        if @todo.save
            response = { message: Message.todo_updated, todo: @todo }
            json_response(response, :ok)
        else
            response = { message: Message.todo_not_saved, errors: @todo.errors}
            json_response(response, 422)
        end
    end

    def destroy
        @todo = Todo.find(params[:id])

        if @todo.destroy
            response = { message: Message.todo_removed }
            json_response(response, :ok)
        else
            response = { message: Message.todo_not_removed }
            json_response(response, 404)
        end
    end

    private

    def todo_params
        params.permit(:title, :category)
    end
end
