class EventsController < ApplicationController
  before_action :find_story
  
  # GET /events
  # GET /events.json
  def index
    @events = @story.events.ready.page(params[:page]).per(30)
    @page=params[:page]

    respond_to do |format|
      format.html 
      format.json{ render json: @story.timeline(@events) }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = @story.events.find(params[:id])
    params[:mode]="book" unless ["book","slide","wall"].include? params[:mode]
    @mode="show_"<<params[:mode]

    respond_to do |format|
      format.html { render @mode }
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = @story.events.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = @story.events.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = @story.events.build(event_params)
    @event.user=current_user
    saved=false

    Event.transaction do
      saved=@event.save
      @event.crumbs<<current_user.tmp_event.crumbs
    end

    respond_to do |format|
      if saved
        format.html { redirect_to [@story,@event], notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = @story.events.find(params[:id])

    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to [@story,@event], notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = @story.events.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to story_events_path(@story) }
      format.json { head :no_content }
    end
  end

  private 
    def find_story
      @story=current_user.stories.find params[:story_id]
      current_story_set @story
      redirect_to new_story_path unless @story
    end

    def event_params
      params.require(:event).permit(:caption, :description, :duration, :start_date)
    end
  
end
