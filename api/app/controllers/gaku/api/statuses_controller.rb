module Gaku
  module Api
    class StatusesController < ActionController::API

      def show
        render json: { status: :running }
      end
    end
  end
end
