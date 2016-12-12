class AddLocationToMeetups < ActiveRecord::Migration
  def self.up
    change_table :meetups do |table|
      table.string :location, null: false
    end
  end

  def self.down
    remove_column :meetups, :location
  end
end
