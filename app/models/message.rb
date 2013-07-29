class Message < ActiveRecord::Base
	validates :kind,:content,:presence=>true

	belongs_to :sender,:class_name=>"User",:foreign_key=>"from"
	belongs_to :reciver,:class_name=>"User",:foreign_key=>"to"

	scope :unhandled,->{ where handled:false }
	scope :urgent,->{ where :priority=>0 }
end
