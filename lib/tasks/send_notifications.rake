namespace :notifications do
  desc 'sending notifications'
  task :send => :environment do
  	notifications = Notification.all
  	notifications.each{|n|
  					user = User.find_by_id(n.user)
  					if user.can_send? && user.email_validated? # проверяем можно ли отправлять
  						_n = Notification.find_all_by_user_id(n.user)
              unless _n.empty?
  						  UserMailer.notification(user, _n).deliver
  						  _n.each{|x| x.destroy}
  						  user.update_attribute(:mail_sent, Time.now)
              end
  					end
  				}
  end
end