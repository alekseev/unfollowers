class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update, :email]
  before_filter :admin_only, :only => :detonate
  
  def index
    @limit = Twitter.rate_limit_status.remaining_hits.to_s
    @users = User.all
  end
  
  
  def email
    user = @current_user
    if request.post?
      code = ActiveSupport::SecureRandom.hex(16)
      user.update_attributes(:email => params[:user][:email], :validation_code => code)
      #user.update_attribute(:validation_code, code)
      UserMailer.validation(user, code).deliver
      redirect_to :root
    else
      user.update_attribute(:first_time, false)
    end
  end

  def show
    @user = @current_user
    @profile = @user.profile
    users = Twitter.followers(@profile['screen_name']).users
    @followers = []
    users.map { |u| @followers << u }
  end

  def validate
    user = User.find_by_validation_code(params[:code])
    unless user.nil?
      user.update_attributes(:email_validated => true)
      @validated = "true"
    else
      @validated = "false"
    end
  end

  #def edit
  #  @user = @current_user
  #end

  def update
    unless current_user.email == params[:user][:email]
      code = ActiveSupport::SecureRandom.hex(16)
      current_user.validation_code = code
      current_user.email = params[:user][:email]
      current_user.email_validated = false
      UserMailer.validation(current_user, code).deliver
      r = "email_changed"
    else
      r = "email_not_changed"
    end
    current_user.update_mail_period(params[:user][:mail_period])
    if current_user.save
      render :text => r
    else
      render :text => "false"
    end
  end
  
  def followers
    p current_user.followers
  end
  
  # for debugging...
  def detonate
    session.clear
    User.all.collect(&:destroy)
    redirect_to login_url
  end
end
