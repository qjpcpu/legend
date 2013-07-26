class Story < ActiveRecord::Base
  #attr_accessible :cover, :end_date, :instruction, :start_date, :title

  has_attached_file :cover,
  :styles=>{:middle=>"400x400>",:small=>"32x32",:square=>"200x300#"}, 
  :convert_options=>{
    :middle=>"-quality 75 -strip",
    :square=>"-quality 75 -strip",
    :small=>"-quality 75 -strip"
  },
  :path => ":rails_root/paperclip/:class/:attachment/:id/:style/:filename",
  :url => "/paperclip/:class/:attachment/:id/:style/:filename"
  validates :instruction,:presence=>true
  validates :title,:presence=>true
  validates_attachment :cover, :presence => true
  validates_format_of :cover_content_type, :with => /\Aimage/

  has_many :users_info,class_name:"StoryInfo",foreign_key:"story_id",:dependent=>:destroy
  has_many :users,:through=>:users_info
  has_many :events,:dependent=>:destroy

  def timeline(events)
    date_list=[]
    era_list=[]
    events<<Event.empty_event if events.size==0
    events.each do |e|
      tl=e.to_timeline
      date_list<<tl["date"]
      era_list<<tl["era"]
    end
    
    {
      "timeline"=>{
        "headline"=>title,
        "type"=>"default",
        "text"=>instruction,
        "asset"=>{
          "media"=>cover.url(:middle),
          "credit"=>"",
          "caption"=>""
        },
        "date"=>date_list,
        "era"=>era_list
      }
    }
  end

end
