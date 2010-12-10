module Permalinkable
  extend ActiveSupport::Concern

  included do
    has_permalink :title
    validates :title, :uniqueness => {:case_sensitive => false}, :presence => true
  end

  module ClassMethods
  end

  module InstanceMethods
    def to_param
      permalink
    end
  end
end
