module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :user

    def connect
      self.user = find_user
      unless user
        reject_unauthorized_connection
      end
    end

    private

    def find_user
      Gaku::User.first
      # headers = { "Authorization" => request.params[:auth_token] }
      # Gaku::Api::AuthorizeApiRequest.call(headers).result
    end
  end
end
