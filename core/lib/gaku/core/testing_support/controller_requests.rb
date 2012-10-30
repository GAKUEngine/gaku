# Use this module to easily test Gaku actions within Gaku components
# or inside your application to test routes for the mounted Gaku engine.
#
# Inside your spec_helper.rb, include this module inside the RSpec.configure
# block by doing this:
#
#   require 'gaku/core/testing_support/controller_requests'
#   RSpec.configure do |c|
#     c.include Gaku::Core::TestingSupport::ControllerRequests, :type => :controller
#   end
#
# Then, in your controller tests, you can access gaku routes like this:
#
#   require 'spec_helper'
#
#   describe Gaku::StudentsController do
#     it "can see all the students" do
#       gaku_get :index
#     end
#   end
#
# Use gaku_get, gaku_post, gaku_put or gaku_delete to make requests
# to the Gaku engine, and use regular get, post, put or delete to make
# requests to your application.
#
module Gaku
  module Core
    module TestingSupport
      module ControllerRequests
        def gaku_get(action, parameters = nil, session = nil, flash = nil)
          process_gaku_action(action, parameters, session, flash, "GET")
        end

        # Executes a request simulating POST HTTP method and set/volley the response
        def gaku_post(action, parameters = nil, session = nil, flash = nil)
          process_gaku_action(action, parameters, session, flash, "POST")
        end

        # Executes a request simulating PUT HTTP method and set/volley the response
        def gaku_put(action, parameters = nil, session = nil, flash = nil)
          process_gaku_action(action, parameters, session, flash, "PUT")
        end

        # Executes a request simulating DELETE HTTP method and set/volley the response
        def gaku_delete(action, parameters = nil, session = nil, flash = nil)
          process_gaku_action(action, parameters, session, flash, "DELETE")
        end

        def gaku_xhr_get(action, parameters = nil, session = nil, flash = nil)
          parameters ||= {}
          parameters.reverse_merge!(:format => :json)
          parameters.merge!(:use_route => :spree)
          xml_http_request(:get, action, parameters, session, flash)
        end

        private

          def process_gaku_action(action, parameters = nil, session = nil, flash = nil, method = "GET")
            parameters ||= {}
            process(action, parameters.merge!(:use_route => :gaku), session, flash, method)
          end

      end
    end
  end
end