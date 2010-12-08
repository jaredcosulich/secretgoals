class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :title
      t.string :permalink

      t.timestamps
    end

    add_index :tags, :permalink, :unique => true 
  end

  def self.down
    drop_table :tags
  end
end
