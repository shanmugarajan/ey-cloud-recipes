#
# Cookbook Name:: crontab
# Recipe:: default
#

#if ['util'].include?(node[:instance_role])
#end

  cron "twitter_process_realtime_notifications" do
    minute   '*/2'
    hour     '*'
    day      '*'
    month    '*'
    weekday  '*'
    user     'deploy'
    command  "cd /data/relatednoise_api/current && RAILS_ENV=#{Rails.env} bundle exec rake twitter:quick_realtime &"
  end

