module Gaku
	class Students::CommuteMethodsController < GakuController

		inherit_resources
		respond_to :html, :js

		before_filter :student

		def create
			@commute_method = CommuteMethod.create!(params[:commute_method])
			@student.update_attribute('commute_method_id', @commute_method.id)
			respond_with(@commute_method)
		end

		private

		def student
			@student = Student.find(params[:student_id])
		end

	end
end
