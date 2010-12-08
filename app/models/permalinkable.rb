module Permalinkable
  extend ActiveSupport::Concern

  included do
    before_save :set_permalink
  end

  module InstanceMethods
    def to_param
      permalink
    end
    
    def set_permalink
      self.permalink = title.downcase.gsub(/\s/, '_')
    end
  end
end
