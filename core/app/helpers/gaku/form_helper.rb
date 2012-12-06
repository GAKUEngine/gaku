module Gaku
  module FormHelper

    def remote_form_for(object, options = {}, &block)
      options[:validate] = true
      options[:builder] = ValidateFormBuilder
      options[:html] = {:class => 'remote-form'}
      options[:remote] = true
      form_for(object, options, &block)
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
      locale_name =  object_name.underscore
      object_class = options[:nested_id] ||  object_name
      
      content_tag :div, :class => 'span12' do
        submit = content_tag :div, :class => 'span6' do
          submit_button t(:"#{locale_name}.save"), :id => "submit-#{object_class}-button"
        end 
        cancel_link = link_to_cancel( :id => "cancel-#{object_class}-link")
        submit + cancel_link
      end
    end

    private

    def get_class(object)
      object.class.to_s.underscore.dasherize.split('/').last
    end
  
  end
end
