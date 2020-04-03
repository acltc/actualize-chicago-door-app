class DoorConnectionsController < ApplicationController
  def create
    if DoorConnection.open_door_and_elevator
      flash[:success] = "Door and Elevator are open."
      CloseJob.set(wait: 30.seconds).perform_later
    else
      flash[:danger] = "Failed to Open Door"
    end
    redirect_to "/"
  end
end
