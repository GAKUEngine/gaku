module Gaku
  module Admin
    class BaseController < CoreController

      self.responder = AppResponder
      respond_to :html

      layout :resolve_layout

      before_filter :authorize_admin

      private

      def current_ability
        @current_ability ||= Gaku::AdminAbility.new(current_user)
      end

      def resolve_layout
        case action_name
        when 'index'
          'gaku/layouts/admin/index'
        when 'show'
          'gaku/layouts/admin/show'
        else
          'gaku/layouts/admin/gaku'
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
