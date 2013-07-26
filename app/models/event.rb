class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :story
  belongs_to :cover, :class_name=>'Crumb',:foreign_key => "crumb_id"
  has_many :crumbs,:dependent=>:destroy, :after_add=>:crumb_added

  #attr_accessible :caption, :description, :duration, :start_date,:available
  validates :caption,:start_date,:duration,:presence=>true
  validates_numericality_of :duration, greater_than: 0

  scope :ready, -> {where(:available=>true)}

  include Rails.application.routes.url_helpers

  def to_timeline
    cover.caption||=""
    cover.description||="<a href='"+cover.media.url(:original)+"'>view</a>"
  	date={
  		"startDate"=>start_date.to_s.gsub(/-/,','),
  		"endDate"=>(start_date+duration).to_s.gsub(/-/,','),
  		"headline"=>"<a href='"+(id.nil? ? '#' : story_event_path(self.story,self))+"'>"+caption+"</a>",
  		"text"=>description,
  		"tag"=>"sweet"<<(id.nil? ? '0' : (id%3).to_s),
  		"asset"=>{
  			"media"=>cover.media.url(:middle),
  			"thumbnail"=>cover.media.url(:small),
  			"credit"=>cover.description,
  			"caption"=>cover.caption
  		}
  	}
  	era=date.select{|k| ["startDate","endDate","tag"].include? k}
  	{"date"=>date,"era"=>era}
  end
  
  def self.empty_event
    c=Crumb.new(caption:"",description:"")
    c.media.instance_eval do
      def url(style)
        "/assets/no_events.jpg"
      end
    end
    Event.new(start_date:Date.today,
      duration:1,
      caption:"No more events",
      description:"",
      available:false,
      cover:c
      )
  end

  def crumb_added(crumb)
    unless cover
      self.cover=crumb
      self.save
    end
  end
end
