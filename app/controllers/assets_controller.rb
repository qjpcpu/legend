class AssetsController < ApplicationController
	def show
		cls=params[:class].singularize.capitalize.constantize
		asset=cls.find params[:id]
		attachment=params[:attachment]
		attachment=params[:attachment].singularize unless asset.respond_to? attachment.to_sym
		send_file asset.send(attachment).path(params[:style])
	end
end