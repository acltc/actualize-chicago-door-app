class DoorConnectionsController < ApplicationController
  before_action :check_times, only: [:create]

  def create
    if DoorConnection.open_door_and_elevator
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
