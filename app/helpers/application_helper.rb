module ApplicationHelper
  def include_clixpy?
    ENV["CLIXPY"] && request.referer.include?("secretgoals.com")
  end
end
