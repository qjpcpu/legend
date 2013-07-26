class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :events
  has_many :stories_info,class_name:"StoryInfo",foreign_key:"user_id"
  has_many :stories,:through=>:stories_info

  def tmp_event
    tmp=self.events.where(:available=>false).first
    unless tmp
      tmp=self.events.create(caption:"empty",description:"empty",start_date:Date.today,available:false)
    end
    tmp
  end
  def display_name
    self.nickname||self.email
  end

  
end
