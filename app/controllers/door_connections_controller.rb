class DoorConnectionsController < ApplicationController
  def create
    if DoorConnection.open_door_and_elevator
      if current_user
        puts "*****************"
        puts "#{current_user.first_name} #{current_user.last_name} just logged in"
        puts "*****************"
      end

      flash[:success] = "Door and Elevator are open."
      CloseJob.set(wait: 30.seconds).perform_later
    else
      flash[:danger] = "Failed to Open Door"
    end
    redirect_to "/"
  end
end
