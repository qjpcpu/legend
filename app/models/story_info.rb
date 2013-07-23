class StoryInfo < ActiveRecord::Base
  belongs_to :user
  belongs_to :story
  # attr_accessible :title, :body
end
