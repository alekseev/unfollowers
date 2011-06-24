# Load the rails application
require File.expand_path('../application', __FILE__)

Twitter.configure do |config|
  config.consumer_key = "CpJ2Nj8hnu8eLyS2i0Jhw"
  config.consumer_secret = "49AK0dUZhYE7gTUynWynMaD8Eq9Jp5aN6l5Ll0wtc"
  config.oauth_token = "14348827-whBylMELAXWlr2CEsi0vp2VJtqUZh3m3UiYTXEkiO"
  config.oauth_token_secret = "DDNY04GJMOZEaZ0r41FF2xHzTQyBVUYauHNMStSVg"
end

Twitter.user

# Initialize the rails application
Twi::Application.initialize!