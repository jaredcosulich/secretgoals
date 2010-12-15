class Reply < ActiveRecord::Base
  belongs_to :udpate
  belongs_to :commenter, :class_name => "User"

  validates_inclusion_of :reply_type, :in => %w{reply support congratulation}
end
