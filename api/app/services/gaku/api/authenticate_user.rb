require 'json_web_token'
module Gaku
  module Api
    class AuthenticateUser
      prepend SimpleCommand

      attr_accessor :username, :password

      def initialize(username:, password:)
        @username = username
        @password = password
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
        user = Gaku::User.find_by(username: username)
        return user if user && user.valid_password?(password)

        errors.add(:user_authentication, 'invalid credentials')
        nil
      end


    end
  end
end
