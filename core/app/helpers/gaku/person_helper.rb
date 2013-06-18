module Gaku
  module PersonHelper

    def gender(student)
      if student.gender.nil?
        t(:"gender.unknown")
      else
        if student.gender?
          t(:"gender.male")
        else
          t(:"gender.female")
        end
      end
    end


    def person_caption(person)
      content_tag :caption do
        content_tag :h2 do

          content_tag :ruby do
            concat student_names(person)
            concat content_tag(:rt) { student_names person, reading: true }
          end
        end
      end
    end

    def edit_person_caption(person)
      content_tag :ruby do
        concat student_names(person)
        concat content_tag(:rt) { student_names person, reading: true }
      end
    end

  end
end
