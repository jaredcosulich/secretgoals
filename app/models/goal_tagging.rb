class GoalTagging < ActiveRecord::Base
  belongs_to :goal
  belongs_to :tag
end
