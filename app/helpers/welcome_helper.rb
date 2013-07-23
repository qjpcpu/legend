module WelcomeHelper
	def carousel_content
		img_list=["default_0.jpg","default_1.jpg","default_2.jpg"]
		title_list=["Love Story"]*3
		desc_list=["written by you & me"]*3
		return img_list,title_list,desc_list
	end
end
