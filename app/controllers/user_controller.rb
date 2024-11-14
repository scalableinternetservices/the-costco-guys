class UserController < ApplicationController
    def register_form
        @user = User.new
    end

    def handle_register
        @user = User.new(params.require(:user).permit(:username, :password, :password_confirmation))
        if @user.save
            session[:user] = @user
            redirect_to root_path
        else
            puts @user.errors.full_messages.join(', ')
            render :register_form, status: :unprocessable_entity
        end
    end
end
