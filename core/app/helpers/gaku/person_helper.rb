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

  end
end
