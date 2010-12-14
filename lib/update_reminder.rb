class UpdateReminder

  def self.send_reminders
    late_sql = <<-SQL
      SELECT user_goals.id
        FROM user_goals, updates
       WHERE user_goals.id = updates.user_goal_id
         AND (
          user_goals.last_emailed_update_reminder is null OR
          user_goals.last_emailed_update_reminder + INTERVAL '12 hours' < now()
         )
      GROUP BY user_goals.id, user_goals.notification_delay
      HAVING (MAX(updates.created_at) + (user_goals.notification_delay * INTERVAL '1 day')) < now()
    SQL

    late_user_goal_ids = UserGoal.connection.select_values(late_sql)

    return if late_user_goal_ids.empty?

    late_user_goals = UserGoal.where("user_goals.id in (?)", late_user_goal_ids.join(",")).joins(:user, :goal)
    late_user_goals.each do |ug|
      Emailing.deliver("update_reminder", ug.user_id, ug.id)
      UserGoal.update(ug.id, :last_emailed_update_reminder => Time.new)
    end
  end
end
