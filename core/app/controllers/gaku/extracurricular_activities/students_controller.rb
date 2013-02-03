module Gaku
  class ExtracurricularActivities::StudentsController < GakuController
    inherit_resources
    actions :index, :show, :create, :update, :edit, :delete

    respond_to :js, :html

    before_filter :extracurricular_activity, :only => :new

    def new
      enrolled_students_ids = ExtracurricularActivityEnrollment.where(:extracurricular_activity_id => @extracurricular_activity.id).map {|x| x.student_id}
      @extracurricular_activity_enrollment = ExtracurricularActivityEnrollment.new
      @students = Student.includes([:addresses, :extracurricular_activities, :extracurricular_activity_enrollments]).all
      render 'new'
    end

    def enroll_student
      if params[:student_ids] && params[:student_ids] != ""
        student_ids = params[:student_ids].split(",")
        @extracurricular_activity = ExtracurricularActivity.find(params[:extracurricular_activity_enrollment][:extracurricular_activity_id])
        @students = []

        student_ids.each do |student_id|
          student = Student.find(student_id)
          extracurricular_activity_enrollment = ExtracurricularActivityEnrollment.new(:extracurricular_activity_id => params[:extracurricular_activity_enrollment][:extracurricular_activity_id], :student_id => student.id)
          extracurricular_activity_enrollment.save!
          @students << extracurricular_activity_enrollment.student
        end
        respond_to do |format|
          format.js { render 'enroll_student' }
        end

      end
    end

     def destroy
      @extracurricular_activity_enrollment = ExtracurricularActivityEnrollment.find(params[:extracurricular_activity_enrollment])
      @extracurricular_activity = ExtracurricularActivity.find(@extracurricular_activity_enrollment.extracurricular_activity_id)
      @extracurricular_activity_enrollment.destroy
      respond_with(@extracurricular_activity_enrollment) do |format|
        format.js { render 'destroy' }
      end
    end

    private

    def extracurricular_activity
      @extracurricular_activity =  ExtracurricularActivity.find(params[:extracurricular_activity_id])
    end

  end
end
