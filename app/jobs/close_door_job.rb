class CloseDoorJob < ApplicationJob
  queue_as :default

  def perform
    if job_id == $current_close_door_job_id
      DoorConnection.close_door

      puts "@" * 50
      puts "CLOSE DOOR"
      puts "@" * 50
    end
  end
end
