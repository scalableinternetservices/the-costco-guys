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
        @item = Item.new(params.require(:item).permit(:name, :description, :price, :quantity))
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
        unless session[:user]
          redirect_to login_path and return
        end

        @item = Item.find(params[:id])
        
        if @item.sold_out?
          redirect_to item_path(@item), alert: "Sorry, this item is sold out!" and return
        end

        requested_quantity = params[:quantity].to_i
        if requested_quantity > @item.remaining_quantity
          redirect_to item_path(@item), alert: "Sorry, only #{@item.remaining_quantity} items available!" and return
        end
        
        @order = Order.new(
          item: @item,
          user: User.find(session[:user]["id"]),
          quantity: requested_quantity
        )
        
        if @order.save
          redirect_to item_path(@item), notice: "Order placed successfully!"
        else
          redirect_to item_path(@item), alert: @order.errors.full_messages.join(", ")
        end
    end
end
