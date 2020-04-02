class CloseJob < ApplicationJob
  queue_as :default

  def perform
    DoorConnection.close_door
    sleep 180
    DoorConnection.close_elevator
  end
end
