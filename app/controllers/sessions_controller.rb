class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      if user.verified?
        session[:user_id] = user.id
        redirect_to products_path, notice: t('session.login')
      else
        redirect_to verify_user_path(user), alert: t('session.verify_account')
      end
    else
      flash.now[:alert] = t('session.wrong')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path, notice: t('session.out_of_account')
  end
end
