class AddParamsToEmailing < ActiveRecord::Migration
  def self.up
    add_column :emailings, :params, :text
  end

  def self.down
    remove_column :emailings, :params
  end
end
