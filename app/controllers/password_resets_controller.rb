class PasswordResetsController < ApplicationController
    def new
    end

    def create 
        @user = User.find_by_email(params[:email])
        if @user.present?
        #Send email
            PasswordMailer.with(user: @user).reset.deliver_now
        end

        redirect_to root_path, :notice => 'Password reset link has been sent to your email address'
    end
    def edit 
        @user = User.find_signed(params[:token], purpose: "password_reset")
    rescue ActiveSupport::MessageVerifier::InvalidSignature
        redirect_to sign_in_path, alert: "Your token has expired. Please try again"
    end

    def update
        @user = User.find_signed(params[:token], purpose: "password_reset")
        if @user.update(password_params)
            redirect_to sign_in_path, notice: "Your password was reset successfully. Please sign in."
        else
            render :edit, status: :bad_request
        end
    end
end

private 

def password_params
    params.require(:user).permit(:password, :password_confirmation)
end