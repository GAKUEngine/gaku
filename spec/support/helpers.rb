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

    def ensure_delete_is_working(delete_link, table_rows)
      tr_count = size_of table_rows

      click delete_link 
      accept_alert
        
      wait_until { size_of(table_rows) == tr_count - 1 }
    end

    def flash(text)
      page.should have_selector("#notice", :text => text)
    end

  end
end

RSpec.configure do |config|
  config.include Helpers::Request, :type => :request
end