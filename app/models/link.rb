class Link < ActiveRecord::Base
  belongs_to :source, :polymorphic => true
  has_many :clicks, :class_name => "LinkClick"
end
