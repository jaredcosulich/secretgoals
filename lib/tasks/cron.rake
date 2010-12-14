task :cron => :environment do

  UpdateReminder.send_reminders
  
end
