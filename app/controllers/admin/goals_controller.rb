class Admin::GoalsController < ApplicationController
  def index
    @tags = Tag.order("title asc").all
    @untagged_goal = Goal.includes(:tags).where("tags.id is null").first
    @goals = Goal.includes(:tags).order("id desc").limit(20)
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
end
