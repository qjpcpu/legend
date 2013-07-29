class MessagesController < ApplicationController
  
  def ignore
    @message=Message.find params[:id]
    @message.handled=true
    respond_to do |format|
      if @message.save
        format.js
      else
        render :nothing
      end
    end
  end
  
end
