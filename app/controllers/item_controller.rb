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

    def show_listing
      @item = Item.find(params[:id])
      @ratings = @item.ratings.includes(:user).order(created_at: :desc)
    end

    def create_order
        # Ensure the user is logged in
        unless session[:user]
          redirect_to login_path and return
        end
    
        # Find the item to be ordered
        @item = Item.find(params[:id])
        
        # Create a new order with item, user, and quantity parameters
        @order = Order.new(
          item: @item,
          user: User.find(session[:user]["id"]),
          quantity: params[:quantity]
        )
        
        if @order.save
          redirect_to item_path(@item), notice: "Order placed successfully!"
        else
          redirect_to item_path(@item), alert: @order.errors.full_messages.join(", ")
        end
      end
end
