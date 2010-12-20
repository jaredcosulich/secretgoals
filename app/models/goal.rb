class Goal < ActiveRecord::Base
  include Permalinkable

  has_many :user_goals
  has_many :users, :through => :user_goals
  has_many :updates, :through => :user_goals

  has_many :goal_taggings
  has_many :tags, :through => :goal_taggings


  def self.most_updated(limit=20, bucket_count = 6)
    goal_sql = <<-SQL
      SELECT goals.id, title, permalink, goals.created_at, count(updates.id)
      FROM goals
      LEFT JOIN user_goals on goals.id = user_goals.goal_id
      LEFT JOIN updates on updates.user_goal_id = user_goals.id
      GROUP by 1,2,3, 4
      ORDER by 5 desc, 4 desc
      LIMIT #{limit}
    SQL
    results = connection.select_all(goal_sql)
    results.each_with_index { |r, i| r["bucket"] = i/(limit/bucket_count) }
  end
end
