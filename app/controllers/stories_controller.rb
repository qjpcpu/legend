class StoriesController < ApplicationController
  def index
    @stories=current_user.stories
    respond_to do |format|
      if @stories.empty?
        format.html { redirect_to new_story_path,notice:"Please create your story first!"}
      elsif @stories.size==1
        format.html { redirect_to story_path(@stories.first) }
      else
        format.html
      end
    end
  end

  def create
    @story=Story.new(story_params)
    created=true
    Story.transaction do
      begin
        @story.save!
        current_user.stories<<@story
        current_story=@story
      rescue Exception => e
        created=false
        raise ActiveRecord::Rollback
      end
    end
    if created
      redirect_to @story, notice: 'Story was successfully created.'
    else
      render action: "new"
    end
  end

  def new
    @story=Story.new
  end

  def show
    @story=current_user.stories.find params[:id]
  end

  def edit
    @story=current_user.stories.find params[:id]
  end

  def update
    @story=current_user.stories.find params[:id]
    if @story.update(story_params)
        redirect_to @story, notice: 'story was successfully updated.'
      else
        render action: "edit"
    end
  end

  def destroy
    @story=current_user.stories.find params[:id]
    @story.destroy
    redirect_to stories_url
  end

  def writers
    @story=current_user.stories.find params[:id]
    @honey=@story.users.reject{|x| x==current_user}.first
  end

  def update_writers
    @story=current_user.stories.find params[:id]
    @users=User.where.not(:id=>current_user.id).
      where("email like ? or nickname like ?","%#{params[:writer_id]}%","%#{params[:writer_id]}%").limit(10)
    
    respond_to do |format|
      format.js
    end
  end

  private
    def story_params
      params.require(:story).permit(:cover, :end_date, :instruction, :start_date, :title)
    end

end
