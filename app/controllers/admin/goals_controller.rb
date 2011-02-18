class Admin::GoalsController < ApplicationController
  def index
    @tags = Tag.order("title asc").all
    @untagged_goal = Goal.includes(:tags).where("tags.id is null").first
    @goals = Goal.includes(:tags).order("id desc").limit(20)
    @goal_stats = [
      {:last_24_hours => UserGoal.where("created_at > ?", 24.hours.ago).count},
      {:last_3_days => UserGoal.where("created_at > ?", 3.days.ago).count},
      {:last_week => UserGoal.where("created_at > ?", 1.week.ago).count},
      {:last_week_24_hours => UserGoal.where("created_at BETWEEN ? AND ?", (1.week + 24.hours).ago, 1.week.ago).count},
      {:last_week_3_days => UserGoal.where("created_at BETWEEN ? AND ?", (1.week + 3.days).ago, 1.week.ago).count},
      {:last_week_1_week => UserGoal.where("created_at BETWEEN ? AND ?", 2.weeks.ago, 1.week.ago).count}
    ]

    @update_stats = [
      {:last_24_hours => Update.where("created_at > ?", 24.hours.ago).count},
      {:last_3_days => Update.where("created_at > ?", 3.days.ago).count},
      {:last_week => Update.where("created_at > ?", 1.week.ago).count},
      {:last_week_24_hours => Update.where("created_at BETWEEN ? AND ?", (1.week + 24.hours).ago, 1.week.ago).count},
      {:last_week_3_days => Update.where("created_at BETWEEN ? AND ?", (1.week + 3.days).ago, 1.week.ago).count},
      {:last_week_1_week => Update.where("created_at BETWEEN ? AND ?", 2.weeks.ago, 1.week.ago).count}  
    ]
  end

  def assign_tags
    goal = Goal.find_by_permalink(params[:id])
    params[:goal][:goal_tagging].each do |tag_permalink|
      next if tag_permalink.blank?
      tag = Tag.find_by_permalink(tag_permalink)
      goal.tags << tag unless tag.nil?
    end
    flash[:notice] = "Added #{goal.reload.tags.map(&:permalink).join(", ")} to #{goal.title}"
    redirect_to admin_goals_path
  end

  def create_tag
    tag = Tag.create(params[:tag]) if params[:tag][:title].present?
    flash[:notice] = "Tag #{tag.permalink} created."
    redirect_to admin_goals_path
  end
end
