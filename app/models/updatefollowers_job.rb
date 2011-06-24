class UpdatefollowersJob < Struct.new(:user)
  def perform
    user.update_followers
    user = nil
    
    #Delayed::Job.enqueue UpdatefollowersJob.new(user)
  end    
end