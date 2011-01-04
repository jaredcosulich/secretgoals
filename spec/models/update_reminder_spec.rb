require 'spec_helper'

describe UpdateReminder do
  before :each do
    @user_goal = Factory(:user_goal, :notification_delay => 3, :created_at => 5.days.ago)
  end

  it "should send a reminder to people who haven't updated in notification_delay days" do
    @user_goal.updates.create(:status => 4, :comment => "doesn't matter", :created_at => 73.hours.ago)
    send_reminders
    verify_only_delivery(@user_goal.user.email, /more than\n3 days\nsince/)
    @user_goal.reload.last_emailed_update_reminder.should be > 5.minutes.ago
  end

  it "should send a reminder to multiple people who haven't updated in notification_delay days" do
    Factory(:user_goal, :notification_delay => 3)
    Factory(:user_goal, :notification_delay => 3, :created_at => 5.days.ago)
    @user_goal.updates.create(:status => 4, :comment => "doesn't matter", :created_at => 73.hours.ago)
    send_reminders
    ActionMailer::Base.deliveries.length.should == 2
  end

  it "should not send a reminder if notification_delay is nil" do
    @user_goal.update_attributes(:notification_delay => nil)
    @user_goal.updates.create(:status => 4, :comment => "doesn't matter", :created_at => 73.hours.ago)
    send_reminders
    ActionMailer::Base.deliveries.length.should == 0
  end

  it "should not send a reminder to people who have updated in less than notification_delay days" do
    @user_goal.updates.create(:status => 4, :comment => "doesn't matter", :created_at => 71.hours.ago)
    send_reminders
    ActionMailer::Base.deliveries.length.should == 0
  end

  it "should not send a reminder to people who been reminded recently" do
    @user_goal.updates.create(:status => 4, :comment => "doesn't matter", :created_at => 73.hours.ago)
    @user_goal.update_attribute(:last_emailed_update_reminder, 11.hours.ago)
    send_reminders
    ActionMailer::Base.deliveries.length.should == 0
  end

  def send_reminders
    Delayed::Job.delete_all
    UpdateReminder.send_reminders
    Delayed::Job.all.map(&:invoke_job)
  end

end
