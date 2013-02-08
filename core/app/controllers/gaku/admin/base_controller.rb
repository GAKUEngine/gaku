module Gaku
  module Admin
    class BaseController < GakuController

      layout :resolve_layout

      # before_filter :authorize_admin

      private

      def current_ability
        @current_ability ||= Gaku::AdminAbility.new(current_user)
      end

      def resolve_layout
        case action_name
        when "index"
          "gaku/layouts/index"
        when "show"
          "gaku/layouts/show"
        else
          "gaku/layouts/gaku"
        end
      end

      protected

      def authorize_admin
        begin
          record = model_class.new
        rescue
          record = Object.new
        end
        authorize! :admin, record
        authorize! params[:action].to_sym, record
      end

    end
  end
end
