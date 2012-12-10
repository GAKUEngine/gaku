module Gaku
  module FormHelper

    def remote_form_for(object, options = {}, &block)
      options[:validate] = true
      options[:builder] = ValidateFormBuilder
      options[:html] = {:class => 'remote-form form'}
      options[:remote] = true
      content_tag :div, class: "row-fluid" do
        content_tag :div, class: "span12 well" do
          form_for(object, options, &block)
        end
      end
    end

    def modal_form_for(object, options = {}, &block)
      options[:validate] = true
      options[:builder] = ValidateFormBuilder
      options[:html] = {:'data-type' => 'script', :class => 'remote-form'}
      options[:remote] = true
      form_for(object, options, &block)
    end


    def buttons_for(object, options = {})
      object_name = get_class(object)
      object_class = options[:nested_id] ||  object_name
      
      locale_name =  object_name.underscore
      locale = options[:label] || t("#{locale_name}.save")
      
      content_tag :div, :class => 'row-fluid' do
        content_tag :div, :class => 'span12' do
          concat submit_button( locale , :id => "submit-#{object_class}-button")
          concat link_to_cancel( :id => "cancel-#{object_class}-link")
        end
      end
    end

    private

    def get_class(object)
      object.class.to_s.underscore.dasherize.split('/').last
    end

  end
end
