require "net/http"

class GoogleOauth
  def self.login_url(options)
    "https://accounts.google.com/o/oauth2/v2/auth" +
    "?client_id=#{Rails.application.credentials.google[:client_id]}" +
    "&response_type=code" +
    "&scope=openid%20email" +
    "&redirect_uri=#{Rails.application.credentials.google[:redirect_uri]}" +
    "&state=#{options[:state]}"
  end

  def self.authenticate(options)
    uri = URI.parse("https://www.googleapis.com/oauth2/v4/token")
    response = Net::HTTP.post_form(uri, {
      code: options[:code],
      client_id: Rails.application.credentials.google[:client_id],
      client_secret: Rails.application.credentials.google[:client_secret],
      redirect_uri: Rails.application.credentials.google[:redirect_uri],
      grant_type: "authorization_code",
    })
    json_response = JSON.parse(response.body)
    access_token = json_response["access_token"]
    email = decode_email(json_response["id_token"])
    {
      access_token: access_token,
      email: email,
    }
  end

  def self.decode_email(jwt)
    chunks = jwt.split(".")
    if chunks.length == 3
      raw_data = Base64.decode64(chunks[1])
      JSON.parse(raw_data)["email"]
    else
      ""
    end
  end
end
