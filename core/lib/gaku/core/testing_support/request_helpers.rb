module Gaku
  module Core
    module TestingSupport
      module RequestHelpers

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

        def show_link
          '.show-link'
        end

        def delete_link
          '.delete-link'
        end

        def accept_alert
          page.driver.browser.switch_to.alert.accept if ENV['SELENIUM']
        end

        def size_of(selector)
          page.all(selector).size
        end

        def wait_until_visible(selector)
          wait_for_ajax
          wait_until { find(selector).visible? }
        end

        def wait_until_invisible(selector)
          wait_for_ajax
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

        def click_option(resource)
          find("option[value='#{resource.id}']").click
        end

        def ensure_delete_is_working
          tr_count = size_of table_rows
          within(table) { click delete_link }

          accept_alert

          wait_until { size_of(table_rows) == tr_count - 1 }
        end

        def ensure_cancel_creating_is_working
          click cancel_link

          wait_for_ajax

          invisible? form
          click new_link

          wait_for_ajax
          visible? submit
          invisible? new_link
        end

        def ensure_cancel_modal_is_working
          click cancel_link
          wait_until_invisible modal
        end

        def wait_for_ajax(timeout = Capybara.default_wait_time)
          page.wait_until(timeout) do
            page.evaluate_script 'jQuery.active == 0'
          end
        end

        def has_validations?
          click submit
          wait_until { page.should have_content "can't be blank" }
        end

        def enroll_one_student_via_button(caption)
          find(:css, "input#student-#{student1.id}").set(true)
          wait_until_visible '#students-checked-div'
          within('#students-checked-div') do
            page.should have_content 'Chosen students(1)'
            click_link 'Show'
            wait_until_visible '#chosen-table'
            page.should have_content "#{student1.name}"
            click_button caption
          end
          wait_until_invisible '#student-modal'

          within(table){ page.should have_content "#{student1.name}" }
        end

        def enroll_three_students_via_button(caption)
          find(:css, "input#student-#{student1.id}").set(true)
          find(:css, "input#student-#{student2.id}").set(true)
          find(:css, "input#student-#{student3.id}").set(true)

          wait_until_visible '#students-checked-div'
          within('#students-checked-div') do
            page.should have_content 'Chosen students(3)'
            click_link 'Show'
            wait_until_visible '#chosen-table'
            page.should have_content "#{student1.name}"
            page.should have_content "#{student2.name}"
            page.should have_content "#{student3.name}"
            click_button caption
          end
          wait_until_invisible '#student-modal'

          within(table) do
            page.should have_content "#{student1.name}"
            page.should have_content "#{student2.name}"
            page.should have_content "#{student3.name}"
          end
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
            result * "-"
          end

      end
    end
  end
end
