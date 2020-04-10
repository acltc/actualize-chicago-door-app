class UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @query = params[:query]
    admin_role_id = Role.find_by(name: "admin").id
    @users = User
      .where.not(role_id: admin_role_id)
      .where("first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?", "%#{@query}%", "%#{@query}%", "%#{@query}%")
      .order(:id => :desc)
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

  def edit
    @user = User.find_by(id: params[:id])
    render "edit.html.erb"
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.first_name = params[:first_name]
    @user.last_name = params[:last_name]
    @user.email = params[:email]
    @user.start_date = params[:start_date]
    if @user.save
      flash[:success] = "User updated successfully"
      redirect_to "/users"
    else
      render "edit.html.erb"
    end
  end
end
