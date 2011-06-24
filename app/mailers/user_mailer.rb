class UserMailer < ActionMailer::Base
  default :from => '"Unfollowers.ru" <no-reply@unfollowers.ru>'

  def notification(user, notifications)
  	@user = user
  	@unfollowers = []
  	notifications.each{|n| @unfollowers << n.unfollower}
  	subject = []
  	if @unfollowers.length == 1 
	  	subject = @unfollowers[0].screen_name
	  	subject = subject + " " + I18n.t("mail.notification.subject_one")
  	else
  		@unfollowers.each{|u| subject << u.screen_name}
  		subject = subject * ", "
  		subject = subject + " " + I18n.t("mail.notification.subject_many")
  	end
  	ap subject
  	mail(:to => "#{user.email}", :subject => subject)
  end

  def validation(user, code)
    @user = user
    @code = code
    mail(:to => "#{user.email}", :subject => I18n.t("mail.validation"))
  end
end
