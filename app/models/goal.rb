class Goal < ActiveRecord::Base
  include Permalinkable

  has_many :user_goals
  has_many :users, :through => :user_goals
  has_many :updates, :through => :user_goals

  has_many :goal_taggings
  has_many :tags, :through => :goal_taggings

end
