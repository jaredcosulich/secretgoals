class Link < ActiveRecord::Base
  belongs_to :source, :polymorphic => true
  has_many :clicks, :class_name => "LinkClick"

  def path_with_additional_params(params)
    additional_params = params.delete_if { |k,v| k == "controller" || k == "token" || k == "action" || k == "link" }
    return path if additional_params.empty?

    path_to_follow = path.clone
    path_to_follow << (path_to_follow.index(/\?/).nil? ? "?" : "&")
    path_to_follow << additional_params.collect { |k,v| "#{k}=#{v}"}.join("&")
    path_to_follow
  end
end
