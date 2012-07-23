class StatesController < ApplicationController
	respond_to :json

	def index
		if params[:country_code]
			@states = State.where(:country_id => params[:country_code])
			respond_with @states
		else
			@states = State.all
			respond_with @states
		end
	end


end