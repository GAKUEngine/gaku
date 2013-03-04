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
            concat person
            concat content_tag(:rt) { person.phonetic_reading }
          end
        end
      end
    end

  end
end
