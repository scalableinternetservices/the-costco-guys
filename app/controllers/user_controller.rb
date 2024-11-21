class UserController < ApplicationController
    def register_form
        if session[:user]
            redirect_to root_path
        end
        @user = User.new
    end

    def handle_register
        if session[:user]
            redirect_to root_path
        end
        @user = User.new(params.require(:user).permit(:username, :password, :password_confirmation))
        if @user.save
            session[:user] = @user
            redirect_to root_path
        else
            render :register_form, status: :unprocessable_entity
        end
    end

    def show_profile        
        @orders = Order.includes(:item).where(user_id: session[:user]['id'])
        @listed_items = Item.where(user_id: session[:user]['id']).order(created_at: :desc)
    end
end
