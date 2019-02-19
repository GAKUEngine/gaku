require 'json_web_token'
require 'pry'
module RequestHelpers

  def json
    JSON.parse(response.body).with_indifferent_access
  end

  def msgpack
    ActiveSupport::MessagePack.decode(response.body).with_indifferent_access
  end

  def ensure_ok
    expect(response.status).to eq 200
  end

  def ensure_unprocessable_entity
    expect(response.status).to eq 422
  end

  def ensure_not_found
    expect(response.status).to eq 404
  end

  def ensure_internal_server_error
    expect(response.status).to eq 500
  end


  %i(get post patch delete).each do |m|
    define_method("api_#{m}") do |path, **args|
      api_base(m, path, **args)
    end

    define_method("msgpack_api_#{m}") do |path, **args|
      msgpack_api_base(m, path, **args)
    end
  end

  def api_base(method, path, **args)
    new_args = {
      headers: { "Authorization" => auth_token  }
    }.deep_merge!(args)

    process(method, path, **new_args)
  end

  def msgpack_api_base(method ,path, **args)
    new_args = {
      headers: { 'Accept' => 'application/msgpack',
                'Content-type' => 'application/msgpack' },
      env: {"RAW_POST_DATA" => args.delete(:msgpack).to_msgpack },
      # request should have at least 1 parameter
      params: {test: :test}
    }.deep_merge(args)

    send("api_#{method}", path, **new_args)
  end

  def auth_token
    #JWT: Authorize user
    role = create(:role, name: 'admin')
    user = create(:user)
    user.roles << role
    authenticate = Gaku::Api::AuthenticateUser.new(username: user.username, password: user.password).call
    authenticate.result[:auth_token]
  end

end
