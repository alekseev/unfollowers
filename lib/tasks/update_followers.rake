namespace :unfollowers do
  desc 'updating users followers'
  task :update => :environment do
  	limit = Twitter.rate_limit_status.remaining_hits.to_i # если приложение не в белом списке, то твиттер разрешает 350 запросов в час
  	users = User.all(:order => 'last_update ASC')
  	users.map{|u| (limit-=(u.followers_count/100.0).ceil) > 50 ? u.update_followers : nil} # если осталось больше 50 запросов - запускаем
  end
end