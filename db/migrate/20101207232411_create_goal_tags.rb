class CreateGoalTags < ActiveRecord::Migration
  def self.up
    create_table :goal_tags do |t|
      t.integer :goal_id
      t.integer :tag_id

      t.timestamps
    end
  end

  def self.down
    drop_table :goal_tags
  end
end
