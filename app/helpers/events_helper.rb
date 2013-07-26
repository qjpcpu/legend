module EventsHelper
	def tmp_crumbs
		current_user.tmp_event.crumbs
	end
end
