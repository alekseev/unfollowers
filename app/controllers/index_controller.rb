class IndexController < ApplicationController
  layout "application", :except => [:more]
  before_filter :require_user
    
  def index
    @user = current_user
    if @user.first_time == true
      Delayed::Job.enqueue UpdatefollowersJob.new(@user) # запускаем скачивание фолловеров пока юзер заполняет емэйл
      redirect_to :email
    end
    if @user.last_update.nil?
      @last_update = "nil"
    end
    @followers = @user.followers.reverse
    @unfollowers = @user.unfollowers.reverse
  end
    
  def more
    if current_user.last_update.nil?
      render :text => 0
    else
      @followers = current_user.followers
    end
  end

end
