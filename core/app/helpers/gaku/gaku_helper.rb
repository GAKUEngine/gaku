module Gaku
  module GakuHelper

    include LinkToHelper
    include SortHelper
    include TranslationsHelper
    include PresetsHelper
    include FormHelper
    include ModalHelper
    include HtmlHelper
    include PersonHelper

    def count_div(html_class, &block)
      content_tag :h4, class: "mt-xs mb-0 #{html_class}" do
        block.call
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

    def grading_methods
      Gaku::GradingMethod.all.collect {|s| [s.name.capitalize, s.id] }
    end

    def enrollment_status_types
      EnrollmentStatusType.includes(:translations).collect {|s| [s.name.capitalize, s.id] }
    end

    def enrollment_statuses_inline
      enrollment_status_types = []
      EnrollmentStatus.includes(:translations).each do |e|
        enrollment_status_types << {value: e.id, text: e.name}
      end
      enrollment_status_types.to_json.html_safe
    end

    def class_groups
      Gaku::ClassGroup.all.collect {|s| [s.name.capitalize, s.id] }
    end

    def commute_method_types
      CommuteMethodType.includes(:translations).collect {|s| [s.name.capitalize, s.id] }
    end

    def commute_method_types_inline
      commute_method_types = []
      CommuteMethodType.includes(:translations).each do |e|
        commute_method_types << {value: e.id, text: e.name}
      end
      commute_method_types.to_json.html_safe
    end

    def syllabuses
      Gaku::Syllabus.all.collect { |s| [s.name, s.id] }
    end

    def countries
      Gaku::Country.all.sort_by(&:name).collect { |s| [s.name, s.id] }
    end

    def courses
      Gaku::Course.includes(:syllabus).collect do |c|
        if c.syllabus_name
          ["#{c.syllabus_name}-#{c.code}", c.id]
        else
          ["#{c.code}", c.id]
        end
      end
    end

    def scholarship_statuses
      ScholarshipStatus.includes(:translations).collect {|p| [ p.name, p.id ] }
    end

    def scholarship_statuses_inline
      scholarship_statuses = []
      ScholarshipStatus.includes(:translations).each do |e|
        scholarship_statuses << {value: e.id, text: e.name}
      end
      scholarship_statuses.to_json.html_safe
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

    def achievements
      Gaku::Achievement.all.collect {|a| [a.name, a.id]}
    end

    def schools
      Gaku::School.all.collect { |s| [s.name, s.id] }
    end

    def school_levels
      Gaku::School.primary.school_levels.collect { |sl| [sl.title, sl.id]}
    end

    def roles
      Gaku::Role.all
    end

    def semesters
      Gaku::Semester.all.collect { |s| ["#{s.starting} / #{s.ending}" ,s.id]}
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

  end
end

