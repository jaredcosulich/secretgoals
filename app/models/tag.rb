class Tag < ActiveRecord::Base
  has_many :goal_tags
  has_many :goals, :through => :goal_tags

  before_save :set_permalink

  def latest_updates
    Update.joins(:goal => :tags).where("tags.id = ?", id).order("updates.created_at desc")
  end

  def feeling_good_update_count
    count_sql = <<-SQL
      SELECT count(*)
      FROM updates, (
        SELECT MAX(updates.id) as update_id
        FROM updates, goal_tags
        WHERE updates.goal_id = goal_tags.goal_id
          AND goal_tags.tag_id = #{id}
        GROUP BY updates.goal_id
      ) latest_updates
      WHERE updates.id = latest_updates.update_id
        AND updates.status >= 5
    SQL
    connection.select_value(count_sql)
  end

  def feeling_bad_update_count
    count_sql = <<-SQL
      SELECT count(*)
      FROM updates, (
        SELECT MAX(updates.id) as update_id
        FROM updates, goal_tags
        WHERE updates.goal_id = goal_tags.goal_id
          AND goal_tags.tag_id = #{id}
        GROUP BY updates.goal_id
      ) latest_updates
      WHERE updates.id = latest_updates.update_id
        AND updates.status < 5
    SQL
    connection.select_value(count_sql)
  end

  def set_permalink
    self.permalink = title.downcase.gsub(/\s/, '_')
  end
end
