class UsersController < ApplicationController
    def new
       @user = User.new
   end
   def create
       @user = User.new(user_params)
       if @user.save
            UserMailer.welcome_email(@user).deliver_now
            redirect_to verify_user_path(@user), notice: t('user.code_sent')
       else
           render :new, status: :unprocessable_entity, notice: t('user.try_again')
       end
   end
   def verify
        @user = User.find(params[:id])
    end

    def confirm_verification
        @user = User.find(params[:id])
        if @user.verification_code == params[:verification_code]
            if @user.token_created_at >= 2.minutes.ago
                @user.update(verified: true, verification_code: nil)
                redirect_to new_session_path, notice: t('user.verify_success')
            else
                flash.now[:alert] = t('user.expire')
                render :verify, status: :unprocessable_entity
            end

        else
            flash.now[:alert] = t('user.invalid')
            render :verify, status: :unprocessable_entity
        end
    end
    def resend_verification_code
        @user = User.find(params[:id])
        @user.update(verification_code: SecureRandom.hex(5).to_s, token_created_at: Time.current)
        UserMailer.welcome_email(@user).deliver_now

        redirect_to verify_user_path(@user), notice: t('user.new_code')
    end

   def show
        @user = User.find(params[:id])
    end
   private
   def user_params
       params.require(:user).permit(:email, :username, :password, :password_confirmation)
   end
end

