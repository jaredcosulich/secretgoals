require 'spec_helper'

describe UpdateReminder do
  before :each do
    @user_goal = Factory(:user_goal, :notification_delay => 3)
  end

  it "should send a reminder to people who haven't updated in notification_delay days" do
    @user_goal.updates.create(:status => 4, :comment => "doesn't matter", :created_at => 73.hours.ago)
    ActionMailer::Base.deliveries.clear
    UpdateReminder.send_reminders
    verify_only_delivery(@user_goal.user.email, /more than\n3 days\nsince/)
    @user_goal.reload.last_emailed_update_reminder.should be > 5.minutes.ago
  end

  it "should not send a reminder to people who have updated in less than notification_delay days" do
    @user_goal.updates.create(:status => 4, :comment => "doesn't matter", :created_at => 71.hours.ago)
    ActionMailer::Base.deliveries.clear
    UpdateReminder.send_reminders
    ActionMailer::Base.deliveries.length.should == 0
  end

  it "should not send a reminder to people who been reminded recently" do
    @user_goal.updates.create(:status => 4, :comment => "doesn't matter", :created_at => 73.hours.ago)
    @user_goal.update_attribute(:last_emailed_update_reminder, 11.hours.ago)
    ActionMailer::Base.deliveries.clear
    UpdateReminder.send_reminders
    ActionMailer::Base.deliveries.length.should == 0
  end

end
