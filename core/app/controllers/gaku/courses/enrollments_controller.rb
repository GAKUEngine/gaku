module Gaku
  class Courses::EnrollmentsController < GakuController

    respond_to :js

    def new
      @course = Course.find(params[:course_id])  
      respond_to do |format|
        format.js { render 'gaku/courses/enrollments/class_groups/new' }
      end
    end

    def enroll_student
      @course_enrollment = CourseEnrollment.new(params[:course_enrollment])
      @course = Course.find(params[:course_enrollment][:course_id])
      if @course_enrollment.save
        respond_with(@course_enrollment) do |format|
          format.js { render 'gaku/courses/enrollments/students/enroll' }
        end
      else
        @errors = @course_enrollment.errors
        respond_with(@course_enrollment) do |format|
          format.js { render 'error' }
        end
      end
    end


    def enroll_class_group
      @course = Course.find(params[:id])
      @not_added_students = []
      if !params[:course][:class_group_id].blank?
        @class_group = ClassGroup.find(params[:course][:class_group_id])
        if @class_group.students.empty?
          flash_error(@course, t('alert.empty', :resource => t('class_group.singular'))) and return
        else
          @not_added_students = @class_group.students - @course.students
          if @not_added_students.empty?
            flash_error(@course, t('alert.already_added', :resource => t('student.plural'))) and return
          end
        end
        @course.enroll_class_group(@class_group)
        respond_to do |format|
          format.js { render 'gaku/courses/enrollments/class_groups/enroll' }
        end
      else
        flash_error(@course,t('alert.not_selected', :resource => t('class_group.singular')))
      end
    end

    private

    def flash_error(respond_with_var,message)
      respond_with(respond_with_var) do |format|
        @course.errors[:base] << message
        format.html { render :nothing => true }
        format.js { render 'gaku/courses/enrollments/class_groups/enroll'}
      end
    end

  end
end
