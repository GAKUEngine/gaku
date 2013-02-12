require 'spec_helper'
include Warden::Test::Helpers

module Gaku
  module Core
    module TestingSupport
      module AuthHelpers

        module Controller

          def as_admin
            before(:each) do
              @request.env["devise.mapping"] = ::Devise.mappings[:admin]
              sign_in FactoryGirl.create(:admin) # Using factory girl as an example
            end
          end

        end

        module Request

          def as_admin
            before(:each) do
              user = FactoryGirl.create(:admin)
              login_as user, scope: :user
            end
          end

          def log_in_as_student

            user = FactoryGirl.create(:student_user)
            login_as user, scope: :user

          end

          def sign_in_as!(user)
            visit '/users/sign_in'
            fill_in "user_email", :with => user.email
            fill_in "user_password", :with => 'secret'
            click_button "sign_in"
          end

        end
      end
    end
  end
end
