module ApplicationHelper
  def include_clixpy?
    intra_app = request.referer.starts_with?("http://www.secretgoals.com") || request.referer.starts_with?("http://secretgoals.com")
    ENV["CLIXPY"] && (intra_app)
  end

  def remove_emails(text)
    text.gsub(/\b\w+@\w+\.\w+/, "[private]")
  end
end
