class CreateJoinTableUsersMeetups < ActiveRecord::Migration
  def change
    create_table :users_and_meetups do |table|
      table.integer :user_id, null: false
      table.integer :meetup_id, null: false
    end
  end
end
