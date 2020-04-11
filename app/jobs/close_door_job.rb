class CloseDoorJob < ApplicationJob
  queue_as :default

  def perform
    EntranceRequest.close_door(job_id)
  end
end
