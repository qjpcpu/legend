class CrumbSorterController < ApplicationController
	before_action :upload_shot
  def index
  	@crumbs=current_user.tmp_event.crumbs
  	@album=current_story.events.ready.map{|e| [e.start_date.to_s+" "+e.caption,e.id]}
  end

  def sort
  	@event=current_story.events.find params[:event_id]
  	Crumb.transaction do
  		@event.crumbs<<current_user.tmp_event.crumbs
  	end
  	redirect_to [current_story,@event]
  end

  private
  def upload_shot
    if current_user.tmp_event.crumbs.empty?
      render "/crumb_sorter/empty"
    end
  end
end
