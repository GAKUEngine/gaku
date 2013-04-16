module Gaku
  class StudentPresenter < BasePresenter
    presents :student

    def class_group
      cg = student.class_groups.last
      cg.blank? ? "Empty" : cg
    end

    def seat_number
      sn = student.class_group_enrollments.last
      sn.blank? ? "" : sn.seat_number
    end

    def achievements
      student.achievements.map { |s| s.name }.join(', ')
    end

    def specialties
      student.specialties.map { |s| s.name }.join(', ')
    end

    def simple_grades
      student.simple_grades.map { |s| s.name }.join(', ')
    end

    private

    def handle_none(value)
      if value.present?
        yield
      else
        content_tag :span, "None given", class: "none"
      end
    end

  end
end
