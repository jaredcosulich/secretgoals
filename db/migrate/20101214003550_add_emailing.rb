class AddEmailing < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.token_authenticatable
    end

    create_table :emailings do |t|
      t.integer :user_id
      t.string :email_name
      t.text :body
      t.timestamps
    end
    add_index :emailings, :user_id

    create_table :links do |t|
      t.string :source_type
      t.integer :source_id
      t.string :path
      t.timestamps
    end
    add_index :links, [:source_type, :source_id]


    create_table :link_clicks do |t|
      t.integer :link_id
      t.timestamps
    end
    add_index :link_clicks, :link_id
  end

  def self.down
    remove_column :users, "authentication_token"
    drop_table :link_clicks
    drop_table :links
    drop_table :emailings
  end
end
