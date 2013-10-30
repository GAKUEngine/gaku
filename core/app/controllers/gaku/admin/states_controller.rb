module Gaku
  module Admin
    class StatesController < Admin::BaseController

      #load_and_authorize_resource class: State

      respond_to :js,   only: %i( new create edit update destroy country_states )
      respond_to :html, only: %i( index edit update )

      before_action :set_state, only: %i( edit show update destroy )
      before_action :set_countries

      def country_states
        if params[:state][:country_iso].empty?
          @country = set_default_country
          set_count @country
          if @country
            respond_with @country
          else
            render nothing: true
          end
        else
          @country = Country.where(iso: params[:state][:country_iso]).first
          @states = @country.states
          set_count @country
          respond_with @country
        end
      end

      def destroy
        @state.destroy
        respond_with @state
      end

      def new
        @state = State.new
        respond_with @state
      end

      def create
        @state = State.new(state_params)
        @state.save
        respond_with @state
      end

      def edit
      end

      def update
        @state.update(state_params)
        respond_with @state
      end

      def index
        @country = set_default_country
        set_count @country
        respond_with @country
      end

      private

      def state_params
        params.require(:state).permit(attributes)
      end

      def attributes
        %i( name abbr name_ascii code country_iso )
      end

      def set_state
        @state = State.find(params[:id])
      end

      def set_countries
        @countries = Country.all
      end

      def set_count(object)
        @count = object.states.count unless object.nil?
      end

      def country_preset
        Preset.address('country')
      end

      def set_default_country
        Country.where(iso: country_preset).first
      end

    end
  end
end
