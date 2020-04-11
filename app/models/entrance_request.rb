class EntranceRequest < ApplicationRecord
  validates :close_door_status, :close_elevator_status, presence: true

  def open_door_and_elevator
    # uri = URI.parse("http://#{Rails.application.credentials.quadrelay[:QIPADDRESS]}:#{Rails.application.credentials.quadrelay[:QPORT]}/stateFull.xml?relay1state=1&relay2state=1")
    # http = Net::HTTP.new(uri.host, uri.port)
    # request = Net::HTTP::Get.new(uri.request_uri)
    # request.basic_auth(Rails.application.credentials.quadrelay[:QUSER], Rails.application.credentials.quadrelay[:QPWORD])
    # response = http.request(request)
    # xml_doc = Nokogiri::XML(response.body)
    # if xml_doc.xpath("//relay1state").text == "1" && xml_doc.xpath("//relay2state").text == "1"
    self.close_door_status = CloseDoorJob.set(wait: 5.seconds).perform_later.job_id
    self.close_elevator_status = CloseElevatorJob.set(wait: 15.seconds).perform_later.job_id
    # else
    #   # LOG ERROR DOOR AND ELEVATOR FAILED TO OPEN
    # end
  end

  def self.close_door(job_id)
    latest_entrance_request = EntranceRequest.last
    entrance_request = EntranceRequest.find_by(close_door_status: job_id)
    if entrance_request == latest_entrance_request
      # uri = URI.parse("http://#{Rails.application.credentials.quadrelay[:QIPADDRESS]}:#{Rails.application.credentials.quadrelay[:QPORT]}/stateFull.xml?relay1state=0")
      # http = Net::HTTP.new(uri.host, uri.port)
      # request = Net::HTTP::Get.new(uri.request_uri)
      # request.basic_auth(Rails.application.credentials.quadrelay[:QUSER], Rails.application.credentials.quadrelay[:QPWORD])
      # response = http.request(request)
      # xml_doc = Nokogiri::XML(response.body)
      # if xml_doc.xpath("//relay1state").text == "0"
      puts "@" * 50
      puts "CLOSE DOOR"
      puts "@" * 50
      entrance_request.update(close_door_status: "closed")
      # else
      #   # LOG ERROR DOOR FAILED TO CLOSE
      # end
    else
      entrance_request.update(close_door_status: "cancelled")
    end
  end

  def self.close_elevator(job_id)
    latest_entrance_request = EntranceRequest.last
    entrance_request = EntranceRequest.find_by(close_elevator_status: job_id)
    if entrance_request == latest_entrance_request
      # uri = URI.parse("http://#{Rails.application.credentials.quadrelay[:QIPADDRESS]}:#{Rails.application.credentials.quadrelay[:QPORT]}/stateFull.xml?relay2state=0")
      # http = Net::HTTP.new(uri.host, uri.port)
      # request = Net::HTTP::Get.new(uri.request_uri)
      # request.basic_auth(Rails.application.credentials.quadrelay[:QUSER], Rails.application.credentials.quadrelay[:QPWORD])
      # response = http.request(request)
      # xml_doc = Nokogiri::XML(response.body)
      # if xml_doc.xpath("//relay2state").text == "0"
      puts "@" * 50
      puts "CLOSE ELEVATOR"
      puts "@" * 50
      entrance_request.update(close_elevator_status: "closed")
      # else
      #   # LOG ERROR ELEVATOR FAILED TO CLOSE
      # end
    else
      entrance_request.update(close_elevator_status: "cancelled")
    end
  end

  def self.destroy_old_records
    max_size = 1000
    current_size = EntranceRequest.count
    if current_size > max_size
      ids = EntranceRequest.order(:id).limit(current_size - max_size).pluck(:id)
      EntranceRequest.where(id: ids).delete_all
    end
  end
end
