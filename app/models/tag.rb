class Tag < ActiveRecord::Base
  include Permalinkable

  has_many :goal_taggings
  has_many :goals, :through => :goal_taggings

  def updates
    Update.for_tag(self)
  end

  def user_goals
    UserGoal.for_tag(self)
  end

  def self.most_updated(limit=20, bucket_count = 6)
    goal_sql = <<-SQL
      SELECT tags.id, tags.title, tags.permalink, tags.created_at, count(updates.id)
      FROM tags, goal_taggings, user_goals, updates
      WHERE goal_taggings.tag_id = tags.id
        AND user_goals.goal_id = goal_taggings.goal_id
        AND updates.user_goal_id = user_goals.id
      GROUP by 1,2,3,4
      ORDER by 5 desc, 4 desc
      LIMIT #{limit}
    SQL
    results = connection.select_all(goal_sql)
    results.each_with_index { |r, i| r["bucket"] = i/(limit/bucket_count) }
  end

end
