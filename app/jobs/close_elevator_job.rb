class CloseElevatorJob < ApplicationJob
  queue_as :default

  def perform
    DoorConnection.close_elevator
  end
end
