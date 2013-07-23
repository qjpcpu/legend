module EventsHelper
	def tmp_crumbs
		current_user.tmp_event.crumbs
	end
	def upload_new_event_path
		upload_event_crumbs_path(current_user.tmp_event)
	end
end
