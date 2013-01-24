module Gaku
  module GakuHelper

    include LinkToHelper
    include SortHelper
    include TranslationsHelper
    include PresetsHelper
    include FormHelper
    include ModalHelper
    include HtmlHelper

    def count_div(html_class, &block)
      content_tag :h4, class: "mt-xs mb-0 #{html_class}" do
        block.call
      end
    end

    def grading_methods
      Gaku::GradingMethod.all.collect {|s| [s.name.capitalize, s.id] }
    end

    def enrollment_status_types
      Gaku::EnrollmentStatusType.all.collect {|s| [s.name.capitalize, s.id] }
    end

    def class_groups
      Gaku::ClassGroup.all.collect {|s| [s.name.capitalize, s.id] }
    end

    def commute_method_types
      Gaku::CommuteMethodType.all.collect {|s| [s.name.capitalize, s.id] }
    end

    def syllabuses
      Gaku::Syllabus.all.collect { |s| [s.name, s.id] }
    end

    def countries
      Gaku::Country.all.sort_by(&:name).collect { |s| [s.name, s.id] }
    end

    def courses
      Gaku::Course.all.collect { |c| ["#{c.code}", c.id] }
    end

    def scholarship_statuses
      Gaku::ScholarshipStatus.all.collect {|p| [ p.name, p.id ] }
    end

    def contact_types
      Gaku::ContactType.all.collect {|ct| [ct.name, ct.id]}
    end

    def enrollment_statuses
      Gaku::EnrollmentStatus.all.collect {|es| [es.name, es.id]}
    end

    def specialties
      Gaku::Specialty.all.collect {|s| [s.name, s.id]}
    end

    def genders
      { t(:'gender.female') => false, t(:'gender.male') => true }
    end

    def present(object, klass = nil)
      klass ||= "#{object.class}Presenter".constantize
      presenter = klass.new(object, self)
      yield presenter if block_given?
      presenter
    end

    def required_field
      ('<span class= "label label-important pull-right">' + t(:required) + '</span>').html_safe
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

    def student_specialties_list(student_specialties)
      string = String.new
      student_specialties.ordered.each_with_index do |student_specialty, i|
        string.concat "#{student_specialty.specialty} (#{major_check(student_specialty)})"
        string.concat ", " unless i == student_specialties.count - 1
      end
      string.html_safe
    end

    def major_check(student_specialty)
      student_specialty.is_major ? t(:'specialty.major') : t(:'specialty.minor')
    end

    def resize_image(image, options = {})
      raise "No size given use :size or :width & :height" unless options[:size] or (options[:height] && options[:width])
      height = options[:height] || options[:size]
      width  = options[:width] || options[:size]
      image_tag(image, :style => "height:#{height}px;width:#{width}px") unless image.blank?
    end

  end
end

