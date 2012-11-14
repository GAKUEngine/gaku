module Gaku
  class Students::EnrollmentStatusesController < GakuController
  	inherit_resources

  	respond_to :js, :html

  	before_filter :load_student, :only => [:edit, :update]
  
  	def history
  		@enrollment_status_types = EnrollmentStatusType.all
  		@enrollment_status = EnrollmentStatus.find(params[:id])
  		respond_with(@enrollment_status) do |format| 
  			format.js { render 'history' }
  		end
  	end

  	private

  	def load_student
  		@student = Student.find(params[:student_id])
  	end
  end
end