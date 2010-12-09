module Permalinkable
  extend ActiveSupport::Concern

  included do
    before_save :set_permalink
    validates :title, :uniqueness => {:case_sensitive => false}, :presence => true
  end

  module ClassMethods
    def find_by_permalink(permalink)
      where("permalink = ?", permalink).first or raise ActiveRecord::RecordNotFound.new("Couldn't find #{name} with permalink #{permalink}")
    end
  end

  module InstanceMethods
    def to_param
      permalink
    end

    def set_permalink
      self.permalink = title.downcase.gsub(/\s/, '-')
    end
  end
end
