class RegistrationsController < ApplicationController
    def new
        @user = User.new
    end

    def create 
        @user = User.new(user_params)
        existing_user = User.find_by(email: @user.email)
        if existing_user.present?
          redirect_to sign_up_path, alert: "An account with that email already exists."
          return
        end
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path, notice: "Successfully created account!"
        else
            render :new, status: :unprocessable_entity
        end
    end
    
    
    private

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end