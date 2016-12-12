class AddCreatorsToMeetups < ActiveRecord::Migration
  def self.up
    change_table :meetups do |table|
      table.string :creator, null: false
    end
  end

  def self.down
    remove_column :meetups, :creator
  end
end
