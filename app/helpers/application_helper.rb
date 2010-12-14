module ApplicationHelper
  def include_clixpy?
    puts request.referer
    ENV["CLIXPY"] && request.referer.include?("secretgoals.com")
  end
end
