class UserController < ApplicationController
    def new
       @user = User.new
   end
   def create
       @user = User.new(user_params)
       if @user.save
            UserMailer.welcome_email(@user).deliver_now
            redirect_to @user, notice: 'User was successfully created and welcome email sent.'
       else
           render :new
       end
   end

   def show
        @user = User.find(params[:id])
    end
   private
   def user_params
       params.require(:user).permit(:email, :username, :password, :password_confirmation)
   end
end
