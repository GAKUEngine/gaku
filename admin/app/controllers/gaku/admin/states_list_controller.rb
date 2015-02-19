module Gaku
  module Admin
    class StatesListController < Admin::BaseController

      respond_to :js, :json

      def index
        if params[:country_id]
          @country = Country.find(params[:country_id])

          if params[:preset_id]
            @preset = Preset.find(params[:preset_id])
            @state = @preset['address']['state'] ? State.find(@preset['address']['state']) : nil
          end

          @states = State.where(country_iso: @country.iso).order('name asc')
        else
          @states = State.all
        end

      end
    end
  end
end
