class StatesController < ApplicationController
	respond_to :json

	def index
		if params[:country_numcode]
			@states = State.where(:country_numcode => Country.find(params[:country_id]).numcode)
			respond_with @states
		else
			@states = State.all
			respond_with @states
		end
	end


end
