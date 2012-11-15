module Gaku
  class Students::EnrollmentStatusesController < GakuController
  	inherit_resources

  	respond_to :js, :html

  	before_filter :load_student, :only => [:edit, :update]
  
  	private

  	def load_student
  		@student = Student.find(params[:student_id])
  	end
  end
end