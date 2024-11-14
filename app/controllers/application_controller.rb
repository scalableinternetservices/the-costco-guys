class ApplicationController < ActionController::Base
    before_action :set_username

    def set_username
        if session[:user]
            @username = session[:user]["username"]
        else
            @username = "Guest"
        end
        
    end
end
