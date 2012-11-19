module Gaku
  class Students::EnrollmentStatusesController < GakuController
  	inherit_resources

  	respond_to :js, :html

  	before_filter :load_student, :only => [:revert, :edit, :update]
  
  	def history
  		@enrollment_status = EnrollmentStatus.find(params[:id])
      @enrollment_status_history = @enrollment_status.history
  		
      respond_with(@enrollment_status_history) do |format| 
  			format.js { render 'history' }
  		end
  	end

    def revert 
      @enrollment_status = EnrollmentStatus.find(params[:id])
      prev_enrollment_status_type_id = @enrollment_status.audits.last.audited_changes["enrollment_status_type_id"][0]
      @enrollment_status.update_attribute(:enrollment_status_type_id, prev_enrollment_status_type_id)
      @enrollment_status.audits.last(2).each {|s| s.destroy}

      respond_with(@enrollment_status) do |format| 
        format.js { render 'revert' }
      end
    end

  	private

  	def load_student
  		@student = Student.find(params[:student_id])
  	end
  end
end