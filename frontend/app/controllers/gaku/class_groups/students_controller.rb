module Gaku
  class ClassGroups::StudentsController < GakuController

    respond_to :js, only: %i( new destroy enroll_student )

    def new
      @class_group = ClassGroup.find(params[:class_group_id])
      @students = Student.includes([:addresses, :class_groups, :class_group_enrollments]).all
    end

    def enroll_student
      unless params[:student_ids].blank?
        @class_group = ClassGroup.find(params[:class_group_enrollment][:class_group_id])
        student_ids = params[:student_ids].split(',')
        enroll_student_ids(student_ids)
      end
    end

    def destroy
      @class_group_enrollment = ClassGroupEnrollment.find(params[:class_group_enrollment])
      @class_group = ClassGroup.find(@class_group_enrollment.class_group_id)
      @class_group_enrollment.destroy
    end

    private

    def enroll_student_ids(student_ids)
      @students = []
      student_ids.each  do |student_id|
        student = Student.find(student_id)
        enrollment = ClassGroupEnrollment.create!(class_group_id: params[:class_group_enrollment][:class_group_id], student_id: student.id)
        @students << enrollment.student
      end
    end

  end
end
