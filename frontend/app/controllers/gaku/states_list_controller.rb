module Gaku
  class StatesListController < GakuController
    respond_to :js, :json

    def index
      if params[:country_id]
        @country = Country.find(params[:country_id])
        @states = State.where(country_iso: @country.iso)
        if params[:state_id]
          @state = State.find(params[:state_id])
        else
          @state = Preset.state
        end
      else
        @states = State.all
      end

      respond_with @states
    end
  end
end
