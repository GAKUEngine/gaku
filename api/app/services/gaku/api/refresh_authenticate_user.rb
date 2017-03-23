require 'json_web_token'
module Gaku
  module Api
    class RefreshAuthenticateUser
      prepend SimpleCommand

      attr_accessor :refresh_token

      def initialize(refresh_token)
        @refresh_token = refresh_token
      end

      def call
        if user
          secret = SecureRandom.hex(64)
          $redis.set("token:#{jti}", secret, ex: 20.minutes)
          {
            auth_token: JsonWebToken.encode({user_id: user.id}, exp: 3.minutes.from_now, jti: jti, secret: secret),
            refresh_token: JsonWebToken.encode({user_id: user.id}, exp: 20.minutes.from_now, jti: jti, secret: secret)
          }
        end
      end

      private

      def jti
        @jti ||= SecureRandom.uuid
      end

      def user
        @user ||= User.find(decoded_refresh_token[:user_id]) if decoded_refresh_token
        @user || errors.add(:token, 'Invalid expire token') && nil
      end

      def decoded_refresh_token
        @decoded_refresh_token ||= JsonWebToken.decode(refresh_token, refresh: true)
      end

      # def user
      #   user = Gaku::User.find_by(email: email)
      #   return user if user && user.valid_password?(password)
      #
      #   errors.add(:user_authentication, 'invalid credentials')
      #   nil
      # end


    end
  end
end
