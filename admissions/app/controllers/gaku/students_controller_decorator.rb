module Gaku
  StudentsController.class_eval do

    def soft_delete
      @student = Student.find(params[:id])
      if @student.admission
        @student.admission.admission_phase_records.each do |record|
          record.update_attribute(:is_deleted, true)
        end
        @student.admission.update_attribute(:is_deleted, true)
      end
      @student.soft_delete
      redirect_to students_path, :notice => t(:'notice.destroyed', :resource => t(:'student.singular'))
    end

  end
end
