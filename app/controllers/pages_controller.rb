class PagesController < ApplicationController
  def index
    session[:state] = generate_random_token
    @google_login_url = generate_google_login_url
    render "index.html.erb"
  end

  private

  def generate_random_token
    SecureRandom.hex(10)
  end

  def generate_google_login_url
    "https://accounts.google.com/o/oauth2/v2/auth" +
    "?client_id=#{Rails.application.credentials.google[:client_id]}" +
    "&response_type=code" +
    "&scope=openid%20email" +
    "&redirect_uri=http://localhost:3000/auth/google_oauth2/callback" +
    "&state=#{session[:state]}"
  end
end
