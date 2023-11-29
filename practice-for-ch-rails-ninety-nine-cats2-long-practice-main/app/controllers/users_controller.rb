class UsersController < ApplicationController

    def new 
        @user = User.new
        render :new  
    end

    def create 
        @user = User.new(params)
        if @user.save 
            redirect_to user_url 
        else 
            render json: @user.errors.full_messages, status: 422
            # redirect_to new_user_url 
        end
    end

private 
    def user_params 
        require(:user).permit(:username, :password)
    end 
end