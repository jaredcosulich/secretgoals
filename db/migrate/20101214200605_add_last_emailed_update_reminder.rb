class AddLastEmailedUpdateReminder < ActiveRecord::Migration
  def self.up
    add_column :user_goals, :last_emailed_update_reminder, :timestamp
  end

  def self.down
    remove_column :user_goals, :last_emailed_update_reminder
  end
end
