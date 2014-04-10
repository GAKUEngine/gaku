require 'spec_helper'
include Warden::Test::Helpers

module Gaku::Testing::AuthHelpers

  module Controller
    def as(user)
      @request.env['devise.mapping'] = ::Devise.mappings[:admin] if user == 'admin'
      sign_in create("#{user.to_sym}_user")
    end
  end

  module Feature
    def as(user)
     if user.is_a?(Symbol)
        login_as create("#{user.to_sym}_user"), scope: :user
      else
        login_as user, scope: :user
      end
    end
  end

end

RSpec.configure do |config|
  config.include Gaku::Testing::AuthHelpers::Controller, type: :controller
  config.include Gaku::Testing::AuthHelpers::Feature, type: :feature
end

