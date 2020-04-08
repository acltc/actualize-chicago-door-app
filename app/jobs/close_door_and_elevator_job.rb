class CloseDoorAndElevatorJob < ApplicationJob
  queue_as :default

  def perform
    DoorConnection.close_door
    CloseElevatorJob.set(wait: 180.seconds).perform_later
  end
end
