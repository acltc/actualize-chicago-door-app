class PagesController < ApplicationController
  def index
    session[:state] = random_token
    @google_login_url = GoogleOauth.login_url(state: session[:state])
    render "index.html.erb"
  end

  private

  def random_token
    SecureRandom.hex(10)
  end
end
