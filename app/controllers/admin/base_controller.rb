module Admin
  class BaseController < ApplicationController

    #layout '/layouts/admin'

    before_filter :authorize_admin

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