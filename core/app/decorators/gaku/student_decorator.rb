module Gaku
  class StudentDecorator < PersonDecorator
    decorates 'Gaku::Student'
    delegate_all

    def specialties_list
      object.specialties.map { |s| s.name }.join(', ')
    end

    def achievements_list
      object.achievements.map { |s| s.name }.join(', ')
    end

    def simple_grades_list
      object.simple_grades.map { |s| s.name }.join(', ')
    end

    def class_group
      cg = object.class_groups.last
      cg.blank? ? 'Empty' : cg
    end

    def seat_number
      sn = object.class_group_enrollments.last
      sn.blank? ? '' : sn.seat_number
    end

  end
end