#
# Cookbook Name:: crontab
# Recipe:: default
#

if ['app_master'].include?(node[:instance_role])
  cron "twitter_process_realtime_notifications" do
    minute   '*/2'
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

if ['app'].include?(node[:instance_role])
  cron "twitter_track_tags_realtime" do
    minute   '*/5'
    hour     '*'
    day      '*'
    month    '*'
    weekday  '*'
    user     'deploy'
    command  "cd /data/relatednoise_api/current && RAILS_ENV=staging bundle exec rake poll:twitter_tags_real &"
  end
end
