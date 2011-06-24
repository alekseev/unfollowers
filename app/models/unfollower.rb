class Unfollower < ActiveRecord::Base
  belongs_to :user
  include TweetLink
end
