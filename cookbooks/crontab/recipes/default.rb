#
# Cookbook Name:: crontab
# Recipe:: default
#

if ['util'].include?(node[:instance_role])

  cron "twitter_quick_realtime" do
    minute   '*/2'
    hour     '*'
    day      '*'
    month    '*'
    weekday  '*'
    command  "cd /data/tweetingdead/current && RAILS_ENV=staging bundle exec rake twitter:quick_realtime &"
  end

  cron "twitter_quick_tweetingdead" do
    minute   '*/2'
    hour     '*'
    day      '*'
    month    '*'
    weekday  '*'
    command  "cd /data/tweetingdead/current && RAILS_ENV=staging bundle exec rake twitter:quick_tweetingdead &"
  end

  cron "monit_staging_twitter_real_time" do
    minute   '*/5'
    hour     '*'
    day      '*'
    month    '*'
    weekday  '*'
    command  "cd /data/tweetingdead/current && RAILS_ENV=staging bundle exec rake monit:staging_twitter_real_time &"
  end

  cron "monit_staging_delayed_job" do
    minute   '*/5'
    hour     '*'
    day      '*'
    month    '*'
    weekday  '*'
    command  "cd /data/tweetingdead/current && RAILS_ENV=staging bundle exec rake monit:staging_delayed_job &"
  end

  cron "twitter_offline" do
    minute   '*/45'
    hour     '*'
    day      '*'
    month    '*'
    weekday  '*'
    command  "cd /data/tweetingdead/current && RAILS_ENV=staging bundle exec rake twitter:all_offline &"
  end

  cron "realtime_streaming_FB_Tumblr" do
    minute   '*'
    hour     '*/6'
    day      '*'
    month    '*'
    weekday  '*'
    command  "cd /data/tweetingdead/current && RAILS_ENV=staging bundle exec rake realtime_streaming:realtime &"
  end

  cron "facebook_offline" do
    minute   '*'
    hour     '*/12'
    day      '*'
    month    '*'
    weekday  '*'
    command  "cd /data/tweetingdead/current && RAILS_ENV=staging bundle exec rake facebook:offline &"
  end

  cron "instagram_offline" do
    minute   '*'
    hour     '*/6'
    day      '*'
    month    '*'
    weekday  '*'
    command  "cd /data/tweetingdead/current && RAILS_ENV=staging bundle exec rake instagram:offline &"
  end
end  