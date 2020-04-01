require "net/http"

class SessionsController < ApplicationController
  def create
    email = login_and_get_email
    user = User.find_by(email: email.downcase)
    if user
      session[:user_id] = user.id
    else
      flash[:error] = "Invalid google account"
    end
    redirect_to "/"
  end

  def destroy
    session[:user_id] = nil
    redirect_to "/"
  end

  private

  def login_and_get_email
    if valid_state?
      info = request_google_info_from_code(params[:code])
      email = info["email"]
    else
      email = ""
    end
  end

  def valid_state?
    params[:state] == session[:state]
  end

  def request_google_info_from_code(code)
    uri = URI.parse("https://www.googleapis.com/oauth2/v4/token")
    response = Net::HTTP.post_form(uri, {
      code: code,
      client_id: Rails.application.credentials.google[:client_id],
      client_secret: Rails.application.credentials.google[:client_secret],
      redirect_uri: "http://localhost:3000/auth/google_oauth2/callback",
      grant_type: "authorization_code",
    })
    json_response = JSON.parse(response.body)
    info = decode_jwt(json_response["id_token"])
  end

  def decode_jwt(jwt)
    chunks = jwt.split(".")
    if chunks.length == 3
      raw_data = Base64.decode64(chunks[1])
      JSON.parse(raw_data)
    else
      {}
    end
  end
end
