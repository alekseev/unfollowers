class FollowersController < ApplicationController
  #before_filter :require_user
  layout nil
  
  def index
    #@followers = Twitter.followers(current_user.twitter["screen_name"]).users
    #@followers = Twitter.followers("MacDigger_ru")
    ap @followers
  end

end
