class Gaku::Api::V1::BaseController < Gaku::Api::ApplicationController
  include ActionController::MimeResponds
  attr_reader :current_user

  before_action :set_default_format
  before_action :authenticate_request

  private

  def authenticate_request
    @current_user =  Gaku::Api::AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end

  def set_default_format
    unless [:json, :msgpack].include? request.format.symbol
      request.format = :json
    end
  end

end
