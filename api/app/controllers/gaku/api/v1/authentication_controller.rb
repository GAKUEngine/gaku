module Gaku
  module Api
    module V1
      class AuthenticationController < BaseController
        skip_before_action :authenticate_request

        def authenticate
          command = Gaku::Api::AuthenticateUser.call(
            email: params[:email],
            password: params[:password]
          )

          if command.success?
            render(respond_format => { tokens: command.result })
          else
            render(respond_format => { error: command.errors }, status: :unauthorized)
          end
        end

        def refresh
          refresh_token = params[:refresh_token]
          command = Gaku::Api::RefreshAuthenticateUser.call(params[:refresh_token])

          if command.success?
            render respond_format => { tokens: command.result }
          else
            render respond_format => { error: command.errors }, status: :unauthorized
          end
        end

      end
    end
  end
end
