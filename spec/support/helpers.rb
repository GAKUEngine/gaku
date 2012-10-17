module Helpers
  module Request

    def edit_link 
      '.edit-link'
    end

    def delete_link 
      '.delete-link'
    end

    def accept_alert
      page.driver.browser.switch_to.alert.accept
    end

    def size_of(selector)
      page.all(selector).size
    end
  
    def wait_until_visible(selector)
      wait_until { find(selector).visible? }
    end

    def wait_until_invisible(selector)
      wait_until { !page.find(selector).visible? }
    end

    def click(selector)
      find(selector).click
    end

  end
end

RSpec.configure do |config|
  config.include Helpers::Request, :type => :request
end