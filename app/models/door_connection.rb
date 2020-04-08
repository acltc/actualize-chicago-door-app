require "net/http"

class DoorConnection
  def self.open_door_and_elevator
    begin
      puts "=== open_door_and_elevator"
      # uri = URI.parse("http://#{Rails.application.credentials.quadrelay[:QIPADDRESS]}:#{Rails.application.credentials.quadrelay[:QPORT]}/stateFull.xml?relay1state=1&relay2state=1")
      # http = Net::HTTP.new(uri.host, uri.port)
      # request = Net::HTTP::Get.new(uri.request_uri)
      # request.basic_auth(Rails.application.credentials.quadrelay[:QUSER], Rails.application.credentials.quadrelay[:QPWORD])
      # response = http.request(request)
      # xml_doc = Nokogiri::XML(response.body)
      # xml_doc.xpath("//relay1state").text == "1" && xml_doc.xpath("//relay2state").text == "1"
      $current_close_door_job_id = CloseDoorJob.set(wait: 30.seconds).perform_later.job_id
      $current_close_elevator_job_id = CloseElevatorJob.set(wait: 210.seconds).perform_later.job_id
      return true
    rescue
      false
    end
  end

  def self.close_door
    # uri = URI.parse("http://#{Rails.application.credentials.quadrelay[:QIPADDRESS]}:#{Rails.application.credentials.quadrelay[:QPORT]}/stateFull.xml?relay1state=0")
    # http = Net::HTTP.new(uri.host, uri.port)
    # request = Net::HTTP::Get.new(uri.request_uri)
    # request.basic_auth(Rails.application.credentials.quadrelay[:QUSER], Rails.application.credentials.quadrelay[:QPWORD])
    # response = http.request(request)
    # xml_doc = Nokogiri::XML(response.body)
    # xml_doc.xpath("//relay1state").text == "0"
    puts "=== close_door"
  end

  def self.close_elevator
    # uri = URI.parse("http://#{Rails.application.credentials.quadrelay[:QIPADDRESS]}:#{Rails.application.credentials.quadrelay[:QPORT]}/stateFull.xml?relay2state=0")
    # http = Net::HTTP.new(uri.host, uri.port)
    # request = Net::HTTP::Get.new(uri.request_uri)
    # request.basic_auth(Rails.application.credentials.quadrelay[:QUSER], Rails.application.credentials.quadrelay[:QPWORD])
    # response = http.request(request)
    # xml_doc = Nokogiri::XML(response.body)
    # xml_doc.xpath("//relay2state").text == "0"
    puts "=== close_elevator"
  end
end
