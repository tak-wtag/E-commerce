class UserMailer < ApplicationMailer

    def welcome_email(user)
        @user = user
        @url  = verify_user_url(@user)
        mail(to: @user.email, subject: 'Verify your email')
    end
end
