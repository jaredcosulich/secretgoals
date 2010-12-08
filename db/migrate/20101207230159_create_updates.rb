class CreateUpdates < ActiveRecord::Migration
  def self.up
    create_table :updates do |t|
      t.integer :goal_id
      t.integer :status
      t.text :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :updates
  end
end
