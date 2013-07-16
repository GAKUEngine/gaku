module Gaku
  module Admin
    class StatesController < Admin::BaseController

      load_and_authorize_resource class: Gaku::State

      inherit_resources
      respond_to :js, :html

      before_filter :count, only: [:create, :destroy, :index]
      before_filter :load_country_preset, only: [:index]
      before_filter :load_data

      def country_states
        @country = Country.where(iso: params[:state][:country_iso]).first
        @states = @country.states
        respond_with @states
      end

      protected

      def resource_params
        return [] if request.get?
        [params.require(:state).permit(state_attr)]
      end

      private

      def state_attr
        %i(name abbr name_ascii code country_iso)
      end

      def load_data
        @countries = Gaku::Country.all.collect { |c| [c, c.iso ]}
      end

      def load_country_preset
        @country_preset ||= Gaku::Preset.get('address_country')
        @default_country = Gaku::Country.where(iso: @country_preset).first
      end

      def count
        @count = State.count
      end

    end
  end
end
