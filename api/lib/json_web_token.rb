class JsonWebToken
  class << self
    def encode(payload, exp:, jti:, secret:)
      payload[:exp] = exp.to_i
      payload[:jti] = jti
      JWT.encode(payload, secret)
    end

    def decode(token, refresh: false)
      secret = extract_secret(token, refresh: refresh)
      body = JWT.decode(token, secret)[0]
      HashWithIndifferentAccess.new body
    rescue
      nil
    end

    def extract_secret(token, refresh: false)
      key = JSON.parse(Base64.decode64 token.split('.')[1])['jti']
      $redis.get("token:#{key}").tap do
        $redis.del("token:#{key}") if refresh
      end
    end
  end
end
