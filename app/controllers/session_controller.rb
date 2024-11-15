class SessionController < ApplicationController
    def login_form
        if session[:user]
            redirect_to root_path
        end
    end

    def handle_login
        if session[:user]
            redirect_to root_path
        end
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
            session[:user] = user
            redirect_to root_path
        else
            @msg = "Invalid username or password"
            render :login_form, status: :unprocessable_entity
        end
    end

    def handle_logout
        if session[:user]
            session[:user] = nil
        end
        redirect_to root_path
    end
end
