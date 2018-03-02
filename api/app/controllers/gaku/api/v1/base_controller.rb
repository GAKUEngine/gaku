class Gaku::Api::V1::BaseController < Gaku::Api::ApplicationController
  include ActionController::MimeResponds
  attr_reader :current_user

  before_action :set_default_format
  before_action :authenticate_request

  # rescue_from StandardError do |exception|
  #   render respond_format => { error: exception.message }, status: 500
  # end

  # rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  # rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response


  private

  def respond_format
    request.format.to_sym
  end

  def member_respond_to(object, options = {})
    render({respond_format => object, root: false, adapter: :attributes }.merge!(options))
  end

  def collection_respond_to(collection, options = {})
    render({respond_format => collection, root: false, adapter: :json, meta: meta_for(collection)}.merge!(options))
  end

  def meta_for(collection)
    { count: collection.size }
  end

  def authenticate_request
    @current_user =  Gaku::Api::AuthorizeApiRequest.call(request.headers).result
    render respond_format => { error: 'Not Authorized' }, status: 401 unless @current_user
  end

  def set_default_format
    unless [:json, :msgpack].include? request.format.symbol
      request.format = :json
    end
  end

  def render_unprocessable_entity_response(exception)
    render(respond_format => exception.record.errors, status: :unprocessable_entity)
  end

  def render_not_found_response(exception)
    render(respond_format => { error: "record not found" }, status: :not_found)
  end

end
