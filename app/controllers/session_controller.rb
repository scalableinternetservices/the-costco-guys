class SessionController < ApplicationController
    def login_form
    end

    def handle_login
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
            session[:user] = user
            redirect_to root_path
        else
            @msg = "Invalid email or password"
            render :login_form, status: :unprocessable_entity
        end
    end
end
