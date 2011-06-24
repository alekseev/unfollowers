class User < ActiveRecord::Base
  has_many :followers
  has_many :unfollowers
  has_many :notifications
  include Profile
  include TweetLink
  attr_accessor :followers_tmp
  before_create :update_info
  
  acts_as_authentic do |config|
    config.validate_email_field    = false
    config.validate_login_field    = false
    config.validate_password_field = false
  end
  
  # при создании пользователя запоминаем его логин в твиттере
  def update_info
    self.login = self.twitter["screen_name"]
    self.twitter_id = self.twitter["id"]
    self.followers_count = self.twitter["followers_count"]
    self.name = self.twitter["name"]
  end
  
  def download_followers
    # ставим метку о начале получения фолловеров
    self.update_attribute(:updating, true)
    
    # начинаем получать фолловеров, в процессе обновляем self.updated
    t1 = Time.now
    self.followers_tmp = []
    get_followers
    t2 = Time.now
    
    ap "#{self.login} - #{t2-t1}"
    
    # ставим метку о конце получения фолловеров
    self.update_attributes(:updating => false, :last_update => Time.now)
    self.followers_tmp
  end
  
  def update_followers
    unless self.updating == true
      self.download_followers # получаем фолловеров из твиттера, заносим в память - в @user.followers_tmp
      f_ids = []
      f_ids_tmp = []
      self.followers.each {|f| f_ids << f.twitter_id}
      self.followers_tmp.each {|f| f_ids_tmp << f.twitter_id}
    
      #ищем анфолловеров
      new_unfollowers_ids = f_ids - f_ids_tmp # массив id анфолловеров
      new_unfollowers = [] # массив анфоловеров
      new_unfollowers_ids.each  {|id| new_unfollowers << self.followers.find_by_twitter_id(id)}
    
      # ищем новых фолловеров
      new_followers_ids = f_ids_tmp - f_ids # массив id новых фолловеров
      new_followers = [] # массив фолловеров
      new_followers_ids.each  {|id| self.followers_tmp.each {|f| new_followers << f if f.twitter_id == id}}
      new_followers.reverse!

      # добавляем новых фолловеров
      self.followers << new_followers
    
    # записываем анфолловеров в базу
      new_unfollowers.reverse!
      new_unfollowers.each {|un|
                unfollower = Unfollower.new(un.attributes)
                self.unfollowers << unfollower
                self.followers.find_by_twitter_id(un.twitter_id).destroy
                Notification.create!(:user_id => self.id, :unfollower_id => unfollower.id)
              }
    
      unfollowers = self.unfollowers
      self.followers_tmp = []
    end
  end

  def can_send? # проверяем, можно ли отправлять письмо (берется из пользовательских настроек)
    unless self.mail_sent.nil?
      case self.mail_period
      when "hour"
        Time.now - self.mail_sent > 1.hour ? true : false
      when "day"
        Time.now - self.mail_sent > 1.day ? true : false
      when "week"
        Time.now - self.mail_sent > 1.week ? true : false
      else
        false
      end
    else
      true
    end
  end

  def email_validated?
    self.email_validated
  end

  def update_mail_period(period)
    if %w{hour day week}.include?(period)
      self.mail_period = period
    end
  end
  
  private
  
  def get_followers(cursor = 0)
    if cursor > 0
      followers = Twitter.followers(self.twitter_id, :cursor => cursor)
    else
      followers = Twitter.followers(self.twitter_id)
    end
    followers.users.each do |f|
      self.followers_tmp << Follower.new(:twitter_id  => f["id_str"].to_i,
                                         :user_id     => 1,
                                         :followers   => f["followers_count"],
                                         :following   => f["friends_count"],
                                         :tweets      => f["statuses_count"],
                                         :name        => f["name"],
                                         :screen_name => f["screen_name"],
                                         :image       => f["profile_image_url"],
                                         :description => f["description"])
    end
    if followers['next_cursor'] > 0 # рекурсия, так как твиттер отдает фолловеров порциями по 100 штук
      get_followers(followers['next_cursor'])
    end
  end

end
