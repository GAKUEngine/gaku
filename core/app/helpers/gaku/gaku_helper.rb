module Gaku
  module GakuHelper

    include SortHelper
    include TranslationsHelper
    include FlashHelper

    def tr_for(resource, &block)
      content_tag :tr, id: "#{resource.class.to_s.demodulize.underscore.dasherize}-#{resource.id}" do
        block.call
      end
    end


    def current_parent_controller
      controller.controller_path.split('/').second
    end

    def current_controller_action
      controller.action_name
    end

    def drag_field
      content_tag :td, class: 'sort-handler' do
        content_tag :i, nil, class: 'icon-move'
      end
    end

    def can_edit?
      if controller.action_name == 'show'
        if controller.controller_name == 'students' || controller.controller_name == 'guardians' || controller.controller_name == 'teachers'
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

    def required_field
      content_tag :span, t(:required), class: 'label label-important pull-right'
    end

    def render_js_partial(partial, locals = {})
      unless locals == {}
        escape_javascript(render partial: partial, formats: [:html], handlers: [:erb, :slim], locals: locals)
      else
        escape_javascript(render partial: partial, formats: [:html], handlers: [:erb, :slim])
      end
    end

    def title(text)
      content_for(:title) do
        text
      end
    end

    def color_code(color)
      content_tag :div, nil, style: "width:100px;height:20px;background-color:#{color}"
    end

    def student_specialties_list(specialties)
      comma_separated_list specialties, empty: t(:'empty') do |specialty|
        "#{specialty.specialty} (#{major_check(specialty)})"
      end
    end

    def achievements_show(achievements)
      comma_separated_list achievements, empty: t(:'empty') do |achievement|
        "#{achievement.name} (#{resize_image(achievement.badge, size: 22)})"
      end
    end


    def simple_grades_show(simple_grades)
      comma_separated_list simple_grades, empty: t(:'empty') do |simple_grade|
        "#{simple_grade.name} (#{simple_grade.grade})"
      end
    end

    def major_check(student_specialty)
      student_specialty.major ? t(:'specialty.major') : t(:'specialty.minor')
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

      percentage = number_to_percentage exam.completion(@course_students), precision: 2

      "#{t(:'exam.completion')}:#{percentage} #{t(:'exam.graded')}:#{total - ungraded} #{t(:'exam.ungraded')}:#{ungraded} #{t(:'exam.total')}:#{total}"
    end

    def datepicker_date_format(date)
      date ?  date.strftime('%Y-%m-%d') : Time.now.strftime('%Y-%m-%d')
    end

    def extract_grouped(grouped, resource)
      grouped.map(&resource.to_sym)
    end

    def nested_header(text)
      content_tag :h4, text
    end

    def state_load(object)
      object.country.nil? ? Gaku::State.none : object.country.states
    end

    def disabled?(object)
      object.new_record? || object.country.states.blank?
    end

  end
end

