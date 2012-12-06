module Gaku
  module FormHelper

    def remote_form_for(object, options = {}, &block)
      options[:validate] = true
      options[:builder] = ValidateFormBuilder
      options[:html] = {:class => 'remote-form'}
      options[:remote] = true
      content_tag :div, class: "row-fluid" do
        content_tag :div, class: "span12 well" do
          form_for(object, options, &block)
        end
      end
      #EASY USING
      #build_proc = build_form(object, &form_block)
      #form_for(object, options, &build_proc)

    end

    def modal_form_for(object, options = {}, &block)
      options[:validate] = true
      options[:builder] = ValidateFormBuilder
      options[:html] = {:'data-type' => 'script', :class => 'remote-form'}
      options[:remote] = true
      form_for(object, options, &block)
      #EASY USING
      #build_proc = build_form(object, &form_block)
      #form_for(object, options, &build_proc)
    end


    def test_form_for(object, options = {}, &form_block)
      options[:validate] = true
      options[:builder] = ValidateFormBuilder
      options[:html] = {:class => 'remote-form'}
      options[:remote] = true

      build_proc = build_form(object, &form_block)
      form_for(object, options, &build_proc)
    end


    private

    def build_form(object, &form_block)
      proc do |*args, &block|
        content_tag :div, :class => 'row-fluid mt-l ' do
          content_tag :div, :class => 'span12 well' do
            form_block.call(*args, &block)
            concat content_tag(:div, form_buttons(object), :class => 'row-fluid' )
          end
        end
      end
    end

    def form_buttons(object)
      object_class = get_class(object)
      locale_name = object_class.underscore
      content_tag :div, :class => 'span12' do
        submit = content_tag :div, :class => 'span6' do
          submit_button t(:"#{locale_name}.save"), :id => "submit-#{object_class}-button"
        end
        cancel_link = link_to_cancel( :id => "cancel-#{object_class}-link")
        submit + cancel_link
      end
    end

    def buttons_for(object, options = {})
      object_name = get_class(object)
      locale_name =  object_name.underscore
      object_class = options[:nested_id] ||  object_name

      content_tag :div, :class => 'row-fluid' do
        content_tag :div, :class => 'span12' do
          submit = submit_button(t(:"#{locale_name}.save"), :id => "submit-#{object_class}-button")
          cancel_link = link_to_cancel( :id => "cancel-#{object_class}-link")
          submit + cancel_link
        end
      end
    end

    private

    def get_class(object)
      object.class.to_s.underscore.dasherize.split('/').last
    end

  end
end
