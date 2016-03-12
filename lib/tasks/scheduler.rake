desc "This task is called by the Heroku scheduler add-on"

task :reset_score_day => :environment do
  puts "Updating score day..."
  members=Member.all
  members.each do |u|
    u.scoreday=0
    u.save
  end
  puts "done"
end