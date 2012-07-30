module StudentsHelper
	def gender(student)
		if student.gender.nil?
			t("genders.unknown")
		else
			if student.gender? 
				t("genders.male")
			else
				t("genders.female")
			end
		end
	end
end
