class Update < ActiveRecord::Base
  belongs_to :user_goal

  scope :latest, lambda { |limit| order("created_at desc").limit(limit) }

  scope :feeling_good, where("status > 6")
  scope :feeling_ok, where("status BETWEEN 4 AND 6")
  scope :feeling_bad, where("status < 4")

  def goal
    user_goal.goal
  end

end
