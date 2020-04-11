class CloseElevatorJob < ApplicationJob
  queue_as :default

  def perform
    EntranceRequest.close_elevator(job_id)
  end
end
