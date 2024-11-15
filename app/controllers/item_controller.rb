class ItemController < ApplicationController
    def index
        @items = Item.all
    end

    def create_listing_form
        if !session[:user]
            redirect_to root_path
        end
        @item = Item.new
    end

    def handle_create_listing
        if !session[:user]
            redirect_to root_path
        end
        @item = Item.new(params.require(:item).permit(:name, :description, :price))
        @item.user = User.find(session[:user]["id"])
        if @item.save
            redirect_to root_path
        else
            puts @item.errors.full_messages.join(', ')
            render :create_listing_form, status: :unprocessable_entity
        end
    end
end
