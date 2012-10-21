module Helpers
  module Request

    def self.plural(text)
      a = []
      a = text.split('-')
      p = a.last.pluralize
      result = a[0..-2] << p
      result * "-"
    end

    def self.resource(x)
      @@resource = x
      @@resource_plural = plural(x)
    end

    def self.get
      @@resource
    end

    def tab_link
      "##{@@resource_plural}-tab-link"
    end
    
    def form
      "#new-#{@@resource}" 
    end

    def new_link
      "#new-#{@@resource}-link" 
    end

    def submit
      "#submit-#{@@resource}-button"
    end

    def cancel_link
      "#cancel-#{@@resource}-link"
    end

    def modal
      '.modal'
    end

    def count_div
      ".#{@@resource_plural}-count"
    end

    def table
      "##{@@resource_plural}-index"
    end

    def table_rows
      "##{@@resource_plural}-index tr"
    end

    def edit_link 
      '.edit-link'
    end

    def show_link 
      '.show-link'
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

    def visible?(selector)
      find(selector).visible?
    end

    def invisible?(selector) 
      !page.find(selector).visible?
    end

    def click(selector)
      find(selector).click
    end

    def ensure_delete_is_working
      tr_count = size_of table_rows

      click delete_link 
      accept_alert
        
      wait_until { size_of(table_rows) == tr_count - 1 }
    end

    def ensure_cancel_creating_is_working
      click cancel_link

      wait_until_invisible form
      click new_link

      wait_until_visible submit
      invisible? new_link
    end

    def ensure_cancel_modal_is_working
      click cancel_link
      wait_until_invisible modal
    end

    def flash(text)
      page.should have_selector("#notice", :text => text)
    end

    def flash_created?
      flash 'successfully created'
    end

    def flash_updated?
      flash 'successfully updated'
    end

    def flash_destroyed?
      flash 'successfully destroyed'
    end

    def flash_error_for(field)
      page.should have_selector("div.#{field}formError")
    end

  end
end

RSpec.configure do |config|
  config.include Helpers::Request, :type => :request
end