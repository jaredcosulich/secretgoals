module ApplicationHelper
  def goal_cloud_class(goal)
    classes = %w{1 2 3}
    "size_#{classes.choice}"
  end
end
