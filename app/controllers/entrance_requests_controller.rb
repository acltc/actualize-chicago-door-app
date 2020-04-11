class EntranceRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_times, only: [:create]

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
      flash[:warning] = "Please come back during scheduled hours"
      redirect_to "/"
    end
  end
end
