module Gaku
  module GakuHelper

    include SortHelper
    include TranslationsHelper

    def count_div(html_class, &block)
      content_tag :h4, class: "mt-xs mb-0 #{html_class}" do
        block.call
      end
    end
  
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
        concat form.text_field options[:object_name], class: 'span12', placeholder: t(:'date_placeholder')
      end
    end

    def autocomplete_select(form, options = {})
      content_tag :div, class: 'span3' do
        concat form.label options[:object_name], options[:tag_name]
        concat form.select options[:object_name], options[:collection], {prompt: options[:prompt]}, options[:html_options]
      end
    end

    def drag_field
      content_tag :td, class: 'sort-handler' do
        content_tag :i, nil, class: 'icon-move'
      end
    end


    def can_edit?
      if controller.action_name == "show"
        if controller.controller_name == "students" or controller.controller_name == "guardians"
          false
        else
          true
        end
      else
        true
      end
    end

    def genders
      { t(:'gender.female') => false, t(:'gender.male') => true }
    end

    def style_semester(date)
      date.strftime('')
    end

    def present(object, klass = nil)
      klass ||= "#{object.class}Presenter".constantize
      presenter = klass.new(object, self)
      yield presenter if block_given?
      presenter
    end

    def required_field
      content_tag :span, t(:required), :class => 'label label-important pull-right'
    end

    def print_count(count, text)
      count != 0 ? text + "(" + count.to_s + ")" : text
    end

    def render_js_partial(partial, locals = {})
      unless locals == {}
        escape_javascript(render :partial => partial, :formats => [:html], :handlers => [:erb, :slim], :locals => locals)
      else
        escape_javascript(render :partial => partial, :formats => [:html], :handlers => [:erb, :slim])
      end
    end

    def sortable(column, title = nil)
    	direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    	css_class = column == sort_column ? "current #{sort_direction}" : nil
    	link_to title, {:sort => column, :direction => direction}, {:class => css_class, :remote => true}
    end

    def student_sortable(column, title = nil)
      css_class = column == sort_column ? "current #{sort_direction}" : nil
      direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
      link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
    end

    def flash_color(type)
      case type
        when :notice then "alert alert-info"
        when :success then "alert alert-success"
        when :error then "alert alert-error"
        when :alert then "alert alert-error"
      end
    end

    def render_flash
      escape_javascript(render 'gaku/shared/flash', :flash => flash)
    end

    def title(text)
      content_for(:title) do
        text
      end
    end

    def boolean_image(field)
      if field
        image_tag('tick.png')
      else
        image_tag('cross.png')
      end
    end

    def color_code(color)
      content_tag :div, nil, :style => "width:100px;height:20px;background-color:#{color}"
    end

    def resize_image(image_url, options = {})
      raise "No size given use :size or :width & :height" unless options[:size] or (options[:height] && options[:width])
      height = options[:height] || options[:size]
      width  = options[:width]  || options[:size]
      image_tag(image_url, :style => "height:#{height}px;width:#{width}px") unless image_url.blank?
    end


    def student_specialties_list(specialties)
      comma_separated_list specialties, :empty => t(:'empty') do |specialty|
        "#{specialty.specialty} (#{major_check(specialty)})"
      end
    end

    def achievements_show(achievements)
      comma_separated_list achievements, :empty => t(:'empty') do |achievement|
        "#{achievement.name} (#{resize_image(achievement.badge, :size => 22)})"
      end
    end


    def simple_grades_show(simple_grades)
      comma_separated_list simple_grades, :empty => t(:'empty') do |simple_grade|
        "#{simple_grade.name} (#{simple_grade.grade})"
      end
    end

    def major_check(student_specialty)
      student_specialty.is_major ? t(:'specialty.major') : t(:'specialty.minor')
    end

    def comma_separated_list(objects, options = {}, &block)
      if objects.any?
        objects.map do |object|
          block_given? ? block.call(object) : object
        end.join(', ').html_safe
      else
        options[:empty]
      end
    end

    def chooser_preset
      @chooser_preset ||= Gaku::Preset.chooser_table_fields
    end

    def enabled_field?(field)
      chooser_preset[field].to_i == 1 rescue true
    end

    def prepare_target(nested_resource, address)
      return nil if nested_resource.blank?
      [nested_resource, address].flatten
    end

    def prepare_resource_name(nested_resources, resource)
      @resource_name = [nested_resources.map {|r| r.is_a?(Symbol) ? r.to_s : get_class(r) }, resource.to_s].flatten.join '-'
    end

    def exam_completion_info(exam)
      @course_students ||= @course.students
      ungraded = exam.ungraded(@course_students)
      total = exam.total_records(@course_students)

      percentage = number_to_percentage exam.completion(@course_students), :precision => 2

      "#{t(:'exam.completion')}:#{percentage} #{t(:'exam.graded')}:#{total - ungraded} #{t(:'exam.ungraded')}:#{ungraded} #{t(:'exam.total')}:#{total}"
    end

    def datepicker_date_format(date)
      date ?  date.strftime('%Y-%m-%d') : Time.now.strftime('%Y-%m-%d')
    end

    def calendar_icon
      content_tag(:i, nil, :class => ' icon-calendar')
    end

    def extract_grouped(grouped, resource)
      grouped.map(&resource.to_sym)
    end

    def nested_header(text)
      content_tag :h4, text
    end

    def student_names(student)
      @names_preset ||= Gaku::Preset.get(:names)
      result = @names_preset.gsub(/%(\w+)/) do |name|
        case name
        when '%first' then student.name
        when '%middle' then student.middle_name
        when '%last' then student.surname
        end
      end
      result.gsub(/\s+/, " ").strip
    end

  end
end

