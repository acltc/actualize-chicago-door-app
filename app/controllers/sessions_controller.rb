class SessionsController < ApplicationController
  def create
    email = request_google_email
    user = User.find_by(email: email.downcase)
    if user
      session[:user_id] = user.id
    else
      flash[:danger] = "Invalid google account"
    end
    redirect_to "/"
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/"
  end

  private

  def request_google_email
    if params[:state] == session[:state]
      response = GoogleOauth.authenticate(code: params[:code])
      email = response[:email]
    else
      email = ""
    end
  end
end
