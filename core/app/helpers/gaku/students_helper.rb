module Gaku
	module StudentsHelper
		def gender(student)
			if student.gender.nil?
				t("gender.unknown")
			else
				if student.gender?
					t("gender.male")
				else
					t("gender.female")
				end
			end
		end

    def surname_reading_title
    	t(:phonetic_reading) + " ("+t(:surname)+")"
    end

    def name_reading_title
      t(:phonetic_reading) + " ("+t(:given_name)+")"
    end

    def surname_title
    	t(:name)+" ("+t(:surname)+")"
    end

    def name_title
    	t(:name)+" ("+t(:given_name)+")"
    end
	end
end
