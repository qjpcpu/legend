class CrumbsController < ApplicationController
  before_action :find_event

  # GET /events/:event_id/crumbs/upload
  # GET /events/:event_id/crumbs/upload.json
  def upload
    @crumbs = @event.crumbs

    respond_to do |format|
      format.html # upload.html.erb
      format.json { render json: @crumbs.map{|crumb| crumb.to_jq_upload } }
    end
  end
  # POST /events/:event_id/crumbs/upload
  # POST /events/:event_id/crumbs/upload.json
  def upload_one
    @crumb = @event.crumbs.build(crumb_params)

    respond_to do |format|
      if @crumb.save
        format.html {  
          render :json => [@crumb.to_jq_upload].to_json,  
          :content_type => 'text/html',  
          :layout => false  
        }
        format.json { render json: {files: [@crumb.to_jq_upload]}, status: :created, location: [@event,@crumb]  }
      else
        format.html { render action: "new" }
        format.json { render json: @crumb.errors, status: :unprocessable_entity }
      end
    end
  end


  # GET /events/:event_id/crumbs/1/edit
  def edit
    @crumb = @event.crumbs.find(params[:id])
  end

  # PUT /events/:event_id/crumbs/1
  # PUT /events/:event_id/crumbs/1.json
  def update
    @crumb = @event.crumbs.find(params[:id])

    respond_to do |format|
      if @crumb.update(crumb_params)
        format.html { redirect_to @crumb, notice: 'Crumb was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @crumb.errors, status: :unprocessable_entity }
        format.js { head :no_content }
      end
    end
  end

  # DELETE /events/:event_id/crumbs/1
  # DELETE /events/:event_id/crumbs/1.json
  def destroy
    @crumb = @event.crumbs.find(params[:id])
    @crumb.destroy

    respond_to do |format|
      format.html { redirect_to [@event.story,@event] }
      format.json { head :no_content }
    end
  end

  private
    def find_event
      @event=Event.find params[:event_id]
    end
    def crumb_params
      params.require(:crumb).permit(:caption, :description, :media)
    end
end
