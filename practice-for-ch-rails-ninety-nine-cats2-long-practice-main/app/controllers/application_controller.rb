class ApplicationController < ActionController::Base

    #CRLLL
    
    helper_method :logged_in?, :current_user

    def current_user 
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def require_login 
        redirect_to new_session_url unless logged_in?
    end

    def require_logout 
        redirect_to user_url if logged_in?
    end 

    def logged_in?
        !!current_user
    end

    def login(user)
        session[:session_token] = user.reset_session_token!
        #whut this doin
    end
    
    def logout!
        user = current_user
        if user 
            user.reset_session_token!
        end
        session[:session_token] = nil 
    end

end