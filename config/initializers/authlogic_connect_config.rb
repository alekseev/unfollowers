# This is how your config file should look.
# This is my Heroku config file.
# Heroku recommends setting environment variables on their system

case Rails.env
when "development"
  AuthlogicConnect.config = YAML.load_file("config/authlogic.yml")
when "production"
  AuthlogicConnect.config = {
    :connect => {
      :twitter => {
        :key => "CpJ2Nj8hnu8eLyS2i0Jhw",
        :secret => "49AK0dUZhYE7gTUynWynMaD8Eq9Jp5aN6l5Ll0wtc",
        :label => "Twitter"
      }
    }
  }
end