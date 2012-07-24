class StatesController < ApplicationController
	respond_to :json

	def index
		if params[:country_id]
			@country = Country.find(params[:country_id])
			@states = State.where(:country_numcode => @country.numcode).order('name asc')
			respond_with @states
		else
			@states = State.all
			respond_with @states
		end
	end


end
