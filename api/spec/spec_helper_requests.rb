require 'spec_helper'
require 'support/request_helpers'
RSpec.configure do |config|

  config.include RequestHelpers, type: :request
  config.include Rails.application.routes.url_helpers

end
