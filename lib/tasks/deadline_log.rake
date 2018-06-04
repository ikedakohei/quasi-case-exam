desc "This task is called by the Heroku scheduler add-on"
task deadline_log: :environment do
  Card.deadline_log
end