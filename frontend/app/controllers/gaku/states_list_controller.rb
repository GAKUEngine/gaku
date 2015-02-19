module Gaku
  class StatesListController < GakuController
    respond_to :js, :json

    def index
      if params[:country_id]
        @country = Country.find(params[:country_id])
        @states = State.where(country_iso: @country.iso).order('name asc')
        @state = Preset.state
      else
        @states = State.all
      end

      respond_with @states
    end
  end
end
