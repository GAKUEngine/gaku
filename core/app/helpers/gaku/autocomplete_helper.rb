module Gaku::AutocompleteHelper

  def autocomplete_text_field(form, options = {})
    content_tag :div, class: 'col-sm-3' do
      concat form.label options[:object_name], options[:tag_name], class: 'control-label'
      concat form.text_field options[:object_name],
                             class: 'form-control input-sm js-autocomplete',
                             data: { autocomplete_source: load_autocomplete_data_students_path(class_name: options[:class_name], column: options[:column]) }
    end
  end

  def autocomplete_date_field(form, options = {})
    content_tag :div, class: 'col-sm-3' do
      concat form.label options[:object_name], options[:tag_name], class: 'control-label'
      concat form.text_field options[:object_name], class: 'form-control input-sm', placeholder: t(:'date.placeholder')
    end
  end

  def autocomplete_select(form, options = {})
    content_tag :div, class: 'col-sm-3' do
      concat form.label options[:object_name], options[:tag_name], class: 'control-label'
      concat form.select(
        options[:object_name],
        options[:collection],
        {prompt: options[:prompt], selected: options[:selected]},
        class: 'form-control input-sm'
      )
    end
  end

end
