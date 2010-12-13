class AddNotificationDelay < ActiveRecord::Migration
  def self.up
    add_column :user_goals, :notification_delay, :integer
  end

  def self.down
    remove_column :user_goals, :notification_delay
  end
end
