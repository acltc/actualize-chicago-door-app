class UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    admin_role_id = Role.find_by(name: "admin").id
    @users = User.where.not(role_id: admin_role_id)
    page_size = 10
    @page = params[:page].to_i
    @page_last = @users.count / page_size
    @users = @users.limit(page_size).offset(@page * page_size)
    render "index.html.erb"
  end

  def new
    @user_data = ""
    render "new.html.erb"
  end

  def create
    @user_data = params[:user_data]
    @errors = User.create_all_from_csv(@user_data)
    if @errors.length == 0
      flash[:success] = "All users created successfully"
      redirect_to "/users"
    else
      render "new.html.erb"
    end
  end
end
