class StatesController < ApplicationController
	respond_to :json

	def index
		if params[:country_numcode]
			@states = State.where(:country_numcode => params[:country_numcode]).order('name asc')
			respond_with @states
		else
			@states = State.all
			respond_with @states
		end
	end


end
