class BaseModels < ActiveRecord::Migration
  def self.up

    create_table :goals do |t|
      t.string :title
      t.string :permalink

      t.timestamps
    end

    add_index :goals, :permalink, :unique => true

    create_table :tags do |t|
      t.string :title
      t.string :permalink

      t.timestamps
    end
    add_index :tags, :permalink, :unique => true


    create_table :goal_taggings do |t|
      t.integer :goal_id, :null => false
      t.integer :tag_id, :null => false

      t.timestamps
    end

    add_index :goal_taggings, [:tag_id, :goal_id]
    add_index :goal_taggings, [:goal_id, :tag_id]

    create_table :user_goals do |t|
      t.integer :goal_id, :null => false
      t.integer :user_id, :null => false

      t.timestamps
    end

    add_index :user_goals, :goal_id
    add_index :user_goals, :user_id

    create_table :updates do |t|
      t.integer :user_goal_id, :null => false
      t.integer :status
      t.text :comment

      t.timestamps
    end

    add_index :updates, :user_goal_id
    add_index :updates, :created_at

  end

  def self.down
    drop_table :updates
    drop_table :user_goals
    drop_table :goals
    drop_table :goal_taggings
    drop_table :tags
  end
end
