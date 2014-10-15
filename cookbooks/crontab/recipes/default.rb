##
## Cookbook Name:: crontab
## Recipe:: default
##
#
#if node[:instance_role] == 'util'
#  cron "redis_socialdata_restore" do
#    minute   '*/2'
#    hour     '*'
#    day      '*'
#    month    '*'
#    weekday  '*'
#    user     'deploy'
#    command  "cd /data/ideation/current && bundle exec rake redis_socialdata:restore RAILS_ENV=production &"
#  end
#end
