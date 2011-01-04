class UpdateReminder

  def self.send_reminders
    late_sql = <<-SQL
      SELECT user_goals.id
        FROM user_goals
        LEFT JOIN updates ON user_goals.id = updates.user_goal_id
        WHERE (
          user_goals.last_emailed_update_reminder is null OR
          user_goals.last_emailed_update_reminder + (INTERVAL '12 hours' + (INTERVAL '24 hours' * (-1 * (date_part('day', user_goals.last_emailed_update_reminder - now()))))) < now()
        )
      GROUP BY user_goals.id, user_goals.notification_delay, user_goals.created_at, user_goals.last_emailed_update_reminder
      HAVING (GREATEST(MAX(updates.created_at), user_goals.created_at) + (user_goals.notification_delay * INTERVAL '1 day')) < now()
    SQL

    late_user_goal_ids = UserGoal.connection.select_values(late_sql)

    return if late_user_goal_ids.empty?

    late_user_goals = UserGoal.where("user_goals.id in (?)", late_user_goal_ids).joins(:user, :goal)
    late_user_goals.each do |ug|
      Emailing.delay.deliver("update_reminder", ug.user_id, ug.id)
      UserGoal.update(ug.id, :last_emailed_update_reminder => Time.new)
    end
  end
end

