module Gaku::Testing::FeatureHelpers

  @@resource = ''
  @@resource_plural = ''

  def set_resource(x)
    @@resource = x
    @@resource_plural = plural(x)
  end

  def get_resource
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

  def js_edit_link
    '.js-edit-link'
  end


  def recovery_link
    '.recovery-link'
  end

  def modal_delete_link
    '.modal-delete-link'
  end

  def show_link
    '.show-link'
  end

  def delete_link
    '.delete-link'
  end

  def close
    '.close'
  end

  def accept_alert
    page.driver.browser.switch_to.alert.accept if Capybara.javascript_driver == :selenium
  end

  def size_of(selector)
    page.all(selector).size
  end

  def visible?(selector)
    find(selector).visible?
  end

  def invisible?(selector)
    page.has_no_selector?(selector)
  end

  def click(selector)
    if Capybara.javascript_driver == :selenium
      find(selector).click
    else
      find(selector).trigger('click')
    end
  end

  def click_option(resource)
    find("option[value='#{resource.id}']").click
  end

  def ensure_delete_is_working
    within(table) { click delete_link }
    accept_alert
  end

  def wait_for_ajax(timeout = Capybara.default_wait_time)
    page.evaluate_script 'jQuery.active == 0'
  end

  def has_validations?
    click submit
    page.has_content? "can't be blank"
  end

  def count?(count)
    within(count_div) { page.has_content? count }
  end

  def check_path(current_url,expected_path)
    uri = URI.parse(current_url)
    "#{uri.path}?#{uri.query}".should == expected_path
  end

  private

  def plural(text)
    a = []
    a = text.split('-')
    p = a.last.pluralize
    result = a[0..-2] << p
    result * '-'
  end

end

RSpec.configure do |config|
  config.include Gaku::Testing::FeatureHelpers, type: :feature
end

