module Profile
  def self.included(base)
    base.class_eval do
      include InstanceMethods
    end
  end
  
  module InstanceMethods
    def twitter
      if token = authenticated_with?(:twitter)
        @twitter ||= JSON.parse(token.get("/account/verify_credentials.json").body)
      end
    end
    
    # primitive profile to show what's possible
    def profile
      unless @profile
        @profile = 
          {
            :id     => twitter["id"],
            :name   => twitter["name"],
            :screen_name => twitter["screen_name"],
            :photo  => twitter["profile_image_url"],
            :link   => "http://twitter.com/#{twitter["screen_name"]}",
            :title  => "Twitter"
          }
      end

      @profile
    end
    
  end
  
end