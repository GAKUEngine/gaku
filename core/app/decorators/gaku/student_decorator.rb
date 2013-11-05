module Gaku
  class StudentDecorator < PersonDecorator
    decorates 'Gaku::Student'
    delegate_all

    def achievements_list
      h.comma_separated_list(object.achievements) do |achievement|
        if achievement.badge_file_name.nil?
          achievement.name
        else
          "#{achievement.name} (#{h.resize_image(achievement.badge, size: 22)})"
        end
      end
    end

    def simple_grades_list
      h.comma_separated_list(object.simple_grades) do |simple_grade|
        "#{simple_grade.name} (#{simple_grade.grade})"
      end
    end

    def student_specialties_list
      h.comma_separated_list(object.student_specialties) do |student_specialty|
        "#{student_specialty.specialty} (#{major_check(student_specialty)})"
      end
    end

    def class_group
      cg = object.class_groups.last
      cg.blank? ? 'Empty' : cg
    end

    def seat_number
      sn = object.class_group_enrollments.last
      sn.blank? ? '' : sn.seat_number
    end

    private

    def major_check(student_specialty)
      student_specialty.major ? h.t(:'specialty.major') : h.t(:'specialty.minor')
    end


  end
end