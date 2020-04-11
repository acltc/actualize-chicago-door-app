class EntranceRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!, only: [:index]
  before_action :check_times, only: [:create]

  def index
    @query = params[:query]
    @entrance_requests = EntranceRequest
      .includes(:user)
      .references(:user)
      .where("users.first_name ILIKE ? OR users.last_name ILIKE ? OR users.email ILIKE ?", "%#{@query}%", "%#{@query}%", "%#{@query}%")
      .order(:id => :desc)
    page_size = 10
    @page = params[:page].to_i
    @page_last = @entrance_requests.count / page_size
    @entrance_requests = @entrance_requests.limit(page_size).offset(@page * page_size)
    render "index.html.erb"
  end

  def create
    @entrance_request = EntranceRequest.new(
      user_id: current_user.id,
    )
    @entrance_request.open_door_and_elevator
    if @entrance_request.save
      EntranceRequest.destroy_old_records
      flash[:success] = "Door and Elevator are open."
    else
      flash[:danger] = "Failed to Open Door"
    end
    redirect_to "/"
  end

  private

  def check_times
    unless current_user.valid_time?
      flash[:warning] = "Please come back during scheduled hours:<br/>#{current_user.formatted_time_slots}"
      redirect_to "/"
    end
  end
end
