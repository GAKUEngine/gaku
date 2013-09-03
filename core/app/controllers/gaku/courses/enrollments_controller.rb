module Gaku
  class Courses::EnrollmentsController < GakuController

    authorize_resource class: false

    respond_to :js, only: %i( new enrolled_student enroll_class_group )

    def new
      @course = Course.find(params[:course_id])
      render 'gaku/courses/enrollments/class_groups/new'
    end

    def enroll_student
      @course = Course.find(params[:course_enrollment][:course_id])

      @course_enrollment = CourseEnrollment.new(params[:course_enrollment])
      if @course_enrollment.save
        render 'gaku/courses/enrollments/students/enroll'
      else
        @errors = @course_enrollment.errors
        render :error
      end
    end


    def enroll_class_group
      @course = Course.find(params[:course_id])
      @not_added_students = []

      unless params[:course][:class_group_id].blank?
        @class_group = ClassGroup.find(params[:course][:class_group_id])
        if @class_group.students.empty?
          flash_error(@course, t(:'alert.empty', resource: t(:'class_group.singular'))) && return
        else
          @not_added_students = @class_group.students - @course.students
          if @not_added_students.empty?
            flash_error(@course, t(:'alert.already_added', resource: t(:'student.plural'))) && return
          end
        end
        @course.enroll_class_group(@class_group)
        render 'gaku/courses/enrollments/class_groups/enroll'
      else
        flash_error(@course,t(:'alert.not_selected', resource: t(:'class_group.singular')))
      end
    end

    private

    def flash_error(respond_with_var,message)
      @course.errors[:base] << message
      render 'gaku/courses/enrollments/class_groups/enroll'
    end

  end
end
