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

  end
end
