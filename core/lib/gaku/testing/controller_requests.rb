module Gaku
  module Testing
    module ControllerRequests
      def gaku_get(action, parameters = nil, session = nil, flash = nil)
        process_gaku_action(action,'GET', parameters, session, flash)
      end

      # Executes a request simulating POST HTTP method and set/volley the response
      def gaku_post(action, parameters = nil, session = nil, flash = nil)
        process_gaku_action(action, 'POST', parameters, session, flash)
      end

      # Executes a request simulating PUT HTTP method and set/volley the response
      def gaku_put(action, parameters = nil, session = nil, flash = nil)
        process_gaku_action(action, 'PUT', parameters, session, flash)
      end

      # Executes a request simulating DELETE HTTP method and set/volley the response
      def gaku_delete(action, parameters = nil, session = nil, flash = nil)
        process_gaku_action(action, 'DELETE', parameters, session, flash)
      end

      def gaku_js_get(action, parameters = nil, session = nil, flash = nil)
        parameters ||= {}
        parameters.reverse_merge!(format: :js)
        parameters.merge!(use_route: :gaku)
        xml_http_request(:get, action, parameters, session, flash)
      end

      def gaku_js_post(action, parameters = nil, session = nil, flash = nil)
        parameters ||= {}
        parameters.reverse_merge!(format: :js)
        parameters.merge!(use_route: :gaku)
        xml_http_request(:post, action, parameters, session, flash)
      end

      def gaku_js_put(action, parameters = nil, session = nil, flash = nil)
        parameters ||= {}
        parameters.reverse_merge!(format: :js)
        parameters.merge!(use_route: :gaku)
        xml_http_request(:put, action, parameters, session, flash)
      end

      private

      def process_gaku_action(action, method = 'GET' ,parameters = nil, session = nil, flash = nil)
        parameters ||= {}
        process(action, method, parameters.merge!(use_route: :gaku), session, flash)
      end

    end
  end
end
