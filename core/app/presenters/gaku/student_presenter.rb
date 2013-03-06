module Gaku
  class StudentPresenter < BasePresenter
    presents :student

    def class_group
      str = ''
      if student.class_group_enrollments.last
        str += "#{student.class_groups.last.grade.try(:to_s)} - #{student.class_groups.last.name}"

        if student.class_group_enrollments.last.seat_number
          #str += "（" + t("class_group_enrollments.seat_number") + ": " + student.class_group_enrollments.last.seat_number.to_s + "）"
        end
      else
        str = t("none")
      end
      str
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

    def primary_address
      "#{student.primary_address.city}, #{student.primary_address.address1}" if student.primary_address
    end

    def primary_contact
      "#{student.primary_contact.contact_type}: #{student.primary_contact.data}" if student.primary_contact
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
