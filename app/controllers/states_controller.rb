class StatesController < ApplicationController
	respond_to :json

	def index
		if params[:country_code]
			@states = State.where(:country_numcode => params[:country_numcode])
			respond_with @states
		else
			@states = State.all
			respond_with @states
		end
	end


end