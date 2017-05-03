class Gaku::Api::V1::BaseController < Gaku::Api::ApplicationController
  include ActionController::MimeResponds
  attr_reader :current_user

  before_action :set_default_format
  before_action :authenticate_request

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  private

  def member_respond_to(object, options = {})
    respond_to do |format|
      format.json { render({ json: object, root: false, adapter: :attributes }.merge!(options)) }
      format.msgpack { render({ msgpack: object, root: false, adapter: :attributes }.merge!(options)) }
    end
  end

  def collection_respond_to(collection, options = {})
    respond_to do |format|
      format.json { render({json: collection, root: :courses, adapter: :json, meta: meta_for(collection)}.merge!(options)) }
      format.msgpack { render({msgpack: collection, root: :courses, adapter: :json, meta: meta_for(collection)}.merge!(options)) }
    end
  end

  def meta_for(collection)
    { count: collection.size , total_count: collection.total_count, page: collection.current_page }
  end

  def authenticate_request
    @current_user =  Gaku::Api::AuthorizeApiRequest.call(request.headers).result
    respond_to do |format|
      format.json { render json: { error: 'Not Authorized' }, status: 401 unless @current_user }
      format.msgpack { render msgpack: { error: 'Not Authorized' }, status: 401 unless @current_user }
    end
  end

  def set_default_format
    unless [:json, :msgpack].include? request.format.symbol
      request.format = :json
    end
  end

  def render_unprocessable_entity_response(exception)
    respond_to do |format|
      format.json { render json: exception.record.errors, status: :unprocessable_entity }
      format.msgpack { render msgpack: exception.record.errors, status: :unprocessable_entity }
    end
  end

  def render_not_found_response(exception)
    respond_to do |format|
      format.json { render json: { error: "record not found" }, status: :not_found }
      format.msgpack { render msgpack: { error: "record not found" }, status: :not_found }
    end
  end

end
