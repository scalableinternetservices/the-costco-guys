class ApplicationController < ActionController::Base
    before_action :process_user

    def process_user
        if session[:user]
            @username = session[:user]["username"]
            @loggedin = true
        else
            @username = "Guest"
            @loggedin = false
        end
    end
end
