#
# Cookbook Name:: crontab
# Recipe:: default
#

# This is for application master
if node[:instance_role] == 'app_master'
  cron "twitter_process_realtime_notifications" do
    minute   '*/1'
    hour     '*'
    day      '*'
    month    '*'
    weekday  '*'
    user     'deploy'
    command  "cd /data/relatednoise_api/current && RAILS_ENV=staging bundle exec rake twitter:quick_realtime &"
  end

  cron "instagram_process_realtime_notifications" do
    minute   '*/2'
    hour     '*'
    day      '*'
    month    '*'
    weekday  '*'
    user     'deploy'
    command  "cd /data/relatednoise_api/current && RAILS_ENV=staging bundle exec rake instagram:data &"
  end
end

if node[:instance_role] == 'app'
  cron "twitter_track_tags_realtime" do
    minute   '*/3'
    hour     '*'
    day      '*'
    month    '*'
    weekday  '*'
    user     'deploy'
    command  "cd /data/relatednoise_api/current && RAILS_ENV=staging bundle exec rake poll:twitter_tags_real &"
  end
end
