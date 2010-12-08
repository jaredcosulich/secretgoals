class Tag < ActiveRecord::Base
  include Permalinkable

  has_many :goal_taggings
  has_many :goals, :through => :goal_taggings
end
