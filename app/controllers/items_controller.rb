class ItemsController < ApplicationController
    def create
        @todo = Todo.find(params[:todo_id])
        @item = @todo.items.build(item_params)

        if @item.save
            response = { message: Message.item_created, item: @item }
            json_response(response, :created)
        else
            response = { message: Message.item_not_created, errors: @item.errors }
            json_response(response, 422)
        end
    end

    def update
        @item = Item.find(params[:id])
        @item.assign_attributes(item_params)

        if @item.save
            response = { message: Message.item_updated, item: @item }
            json_response(response, :ok)
        else
            response = { message: Message.item_not_saved, errors: @item.errors}
            json_response(response, 422)
        end
    end

    def destroy
        @item = Item.find(params[:id])

        if @item.destroy
            response = { message: Message.item_removed }
            json_response(response, :ok)
        else
            response = { message: Message.item_not_removed }
            json_response(response, 404)
        end
    end

    private

    def item_params
        params.permit(:name, :complete)
    end
end
