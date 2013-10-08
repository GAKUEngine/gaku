module Gaku::Testing::ControllerHelpers

  def gaku_get(action, parameters = nil, session = nil, flash = nil)
    process_gaku_action(action,'GET', parameters, session, flash)
  end

  def gaku_post(action, parameters = nil, session = nil, flash = nil)
    process_gaku_action(action, 'POST', parameters, session, flash)
  end

  def gaku_put(action, parameters = nil, session = nil, flash = nil)
    process_gaku_action(action, 'PUT', parameters, session, flash)
  end

  def gaku_patch(action, parameters = nil, session = nil, flash = nil)
    process_gaku_action(action, 'PATCH', parameters, session, flash)
  end

  def gaku_delete(action, parameters = nil, session = nil, flash = nil)
    process_gaku_action(action, 'DELETE', parameters, session, flash)
  end

  def gaku_js_get(action, parameters = nil, session = nil, flash = nil)
    process_js_gaku_action(action, :get, parameters, session, flash)
  end

  def gaku_js_post(action, parameters = nil, session = nil, flash = nil)
    process_js_gaku_action(action, :post, parameters, session, flash)
  end

  def gaku_js_put(action, parameters = nil, session = nil, flash = nil)
    process_js_gaku_action(action, :put, parameters, session, flash)
  end

  def gaku_js_patch(action, parameters = nil, session = nil, flash = nil)
    process_js_gaku_action(action, :patch, parameters, session, flash)
  end

  def gaku_js_delete(action, parameters = nil, session = nil, flash = nil)
    process_js_gaku_action(action, :delete, parameters, session, flash)
  end

  def json_response
    JSON.parse(response.body)
  end

  def ensure_ok
    expect(response.status).to eq 200
  end

  def ensure_not_found
    expect(json_response).to eq({ 'error' => 'The resource you were looking for could not be found.' })
    expect(response.status).to eq 404
  end

  def ensure_unauthorized
    expect(json_response).to eq({ 'error' => 'You need to sign in or sign up before continuing.' })
    expect(response.status).to eq 401
  end

  def api_get(action, params={}, session=nil, flash=nil)
    api_process(action, params, session, flash, 'GET')
  end

  def api_post(action, params={}, session=nil, flash=nil)
    api_process(action, params, session, flash, 'POST')
  end

  def api_put(action, params={}, session=nil, flash=nil)
    api_process(action, params, session, flash, 'PUT')
  end

  def api_delete(action, params={}, session=nil, flash=nil)
    api_process(action, params, session, flash, 'DELETE')
  end

  def api_process(action, params={}, session=nil, flash=nil, method='get')
    scoping = respond_to?(:resource_scoping) ? resource_scoping : {}
    process(action, method, params.merge(scoping).reverse_merge!(format: :json, use_route: :gaku), session, flash)
  end

  private

  def process_gaku_action(action, method = 'GET' ,parameters = nil, session = nil, flash = nil)
    parameters ||= {}
    process(action, method, parameters.merge!(use_route: :gaku), session, flash)
  end

  def process_js_gaku_action(action, method = 'GET' ,parameters = nil, session = nil, flash = nil)
    parameters ||= {}
    parameters.reverse_merge!(format: :js)
    parameters.merge!(use_route: :gaku)
    xml_http_request(method, action, parameters, session, flash)
  end

end

RSpec.configure do |config|
  config.include Gaku::Testing::ControllerHelpers, type: :controller
end
