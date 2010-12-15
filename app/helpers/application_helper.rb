module ApplicationHelper
  def include_clixpy?
    intra_app = request.referer.starts_with?("http://www.secretgoals.com") || request.referer.starts_with?("http://secretgoals.com")
    puts "Referer: #{request.referer} (intra_app: #{intra_app})"
    ENV["CLIXPY"] && (intra_app)
  end
end
