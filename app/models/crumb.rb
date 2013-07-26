class Crumb < ActiveRecord::Base
  has_attached_file :media,
  :styles=>{:middle=>"500x500>",:small=>"32x32",:square=>"200x200#",:book=>"300x163#"}, 
  :convert_options=>{
    :middle=>"-quality 75 -strip",
    :small=>"-quality 75 -strip",
    :square=>"-quality 75 -strip",
    :book=>"-quality 75 -strip"
  },
  :path => ":rails_root/paperclip/:class/:attachment/:id/:style/:filename",
  :url => "/paperclip/:class/:attachment/:id/:style/:filename"
  validates_attachment :media, :presence => true
  validates_format_of :media_content_type, :with => /\Aimage/

  belongs_to :event

  include Rails.application.routes.url_helpers

  def to_jq_upload
    {
      "name" => read_attribute(:media_file_name),
      "size" => read_attribute(:media_file_size),
      "url" => media.url(:original),
      "delete_url" => event_crumb_path(self.event,self),
      "delete_type" => "DELETE" 
    }
  end
end
