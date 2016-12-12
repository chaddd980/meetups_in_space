class Meetup < ActiveRecord::Base
  has_many :users_and_meetups
  has_many :users, :through => :users_and_meetups
  validates :name, presence: true
  validates :description, presence: true
  validates :date, presence: true
  validates :time, presence: true
  validates :location, presence: true
  validates :creator, presence: true
end
