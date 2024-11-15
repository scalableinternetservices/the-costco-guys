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
end
