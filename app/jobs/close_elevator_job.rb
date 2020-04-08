class CloseElevatorJob < ApplicationJob
  queue_as :default

  def perform
    if job_id == $current_close_elevator_job_id
      DoorConnection.close_elevator

      puts "@" * 50
      puts "CLOSE ELEVATOR"
      puts "@" * 50
    end
  end
end
