module Gaku
  class ClassGroups::SemesterAttendancesController < EnrollmentsController

    respond_to :js

    before_action :set_class_group

    def index
      @students = @class_group.students
      @semesters = @class_group.semesters

      check_or_init_semester_attendance

      @semester_attendances = Gaku::SemesterAttendance.where(student_id: @students.pluck(:id), semester_id: @semesters.pluck(:id))
      @semester_attendance_results = @semester_attendances.grouped_for_table

      respond_with @semester_attendances
    end


    def update
      @semester_attendance = Gaku::SemesterAttendance.find(params[:id])
      @semester_attendance.update(semester_attendance_params)
      render nothing: true
    end

    private

    def semester_attendance_params
      params.require(:semester_attendance).permit(semester_attendance_attr)
    end

    def semester_attendance_attr
      %i( days_present days_absent )
    end


    def set_class_group
      @class_group = Gaku::ClassGroup.find(params[:class_group_id])
    end

    def check_or_init_semester_attendance
      ActiveRecord::Base.transaction do
        @students.each do |student|
          @semesters.each do |semester|
            Gaku::SemesterAttendance.where(student_id: student, semester_id: semester).first_or_create
          end
        end
      end
    end

  end
end
