module ApplicationHelper
	def current_story
		Story.find session[:current_story_id]
	end
	def current_story_set(story)
		session[:current_story_id]=story.nil?? nil : story.id
		story
	end
end
