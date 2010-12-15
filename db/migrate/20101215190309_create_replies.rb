class CreateReplies < ActiveRecord::Migration
  def self.up
    create_table :replies do |t|
      t.integer :update_id
      t.integer :commenter_id
      t.string :reply_type
      t.text :comment

      t.timestamps
    end

    add_index :replies, :update_id
    add_index :replies, :commenter_id
  end

  def self.down
    drop_table :replies
  end
end
