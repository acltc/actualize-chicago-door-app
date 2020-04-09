class PagesController < ApplicationController
  before_action :authenticate_admin!, only: [:admin]

  def index
    session[:state] = random_token
    @google_login_url = GoogleOauth.login_url(state: session[:state])
    render "index.html.erb"
  end

  def admin
    render "admin.html.erb"
  end

  private

  def random_token
    SecureRandom.hex(10)
  end
end
