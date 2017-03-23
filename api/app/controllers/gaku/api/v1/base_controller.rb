class Gaku::Api::V1::BaseController < Gaku::Api::ApplicationController
  attr_reader :current_user

  before_action :authenticate_request

  private

  def authenticate_request
    @current_user =  Gaku::Api::AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end
end
