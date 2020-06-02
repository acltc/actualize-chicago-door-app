class SessionsController < ApplicationController
  def create
    access_token, email = authenticated_google_email
    user = User.find_by(email: email.downcase)
    if user
      session[:user_id] = user.id
      session[:access_token] = access_token
    else
      GoogleOauth.revoke_token(access_token)
      flash[:danger] = "Invalid google account"
    end
    redirect_to "/"
  end

  def destroy
    GoogleOauth.revoke_token(session[:access_token])
    session[:user_id] = nil
    session[:access_token] = nil
    redirect_to "/"
  end

  private

  def authenticated_google_email
    if params[:state] == session[:state]
      response = GoogleOauth.authenticate(code: params[:code], base_url: request.base_url)
      [response[:access_token], response[:email]]
    else
      []
    end
  end
end
