module Gaku::AutocompleteHelper

  def autocomplete_text_field(form, options = {})
    content_tag :div, class: 'span3' do
      concat form.label options[:object_name], options[:tag_name]
      concat form.text_field options[:object_name],
                             class: 'js-autocomplete span12',
        data: { autocomplete_source: load_autocomplete_data_students_path(class_name: options[:class_name], column: options[:column]) }
    end
  end

  def autocomplete_date_field(form, options = {})
    content_tag :div, class: 'span3' do
      concat form.label options[:object_name], options[:tag_name]
      concat form.text_field options[:object_name], class: 'span12', placeholder: t(:'date.placeholder')
    end
  end

  def autocomplete_select(form, options = {})
    content_tag :div, class: 'span3' do
      concat form.label options[:object_name], options[:tag_name]
      concat form.select  options[:object_name],
                          options[:collection],
                          { prompt: options[:prompt],
                            selected: options[:selected]
                          },
                          options[:html_options]
    end
  end

end
