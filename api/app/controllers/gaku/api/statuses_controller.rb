module Gaku
  module Api
    class StatusesController < ActionController::API

      def show
        if msgpack_request?
          render msgpack: { status: :running }

        else
          render json: { status: :running }
        end
      end

      private

      def msgpack_request?
        request.format.to_sym == :msgpack
      end
    end
  end
end
