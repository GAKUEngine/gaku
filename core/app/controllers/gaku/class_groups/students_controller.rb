module Gaku
  class ClassGroups::StudentsController < ApplicationController

    inherit_resources
    actions :index, :show, :create, :update, :edit, :delete

    respond_to :js, :html

    def new
      @class_group =  ClassGroup.find(params[:class_group_id])
      enrolled_students_ids = ClassGroupEnrollment.where(:class_group_id => @class_group.id).map {|x| x.student_id}
      @class_group_enrollment = ClassGroupEnrollment.new
      @students = Student.includes([:addresses, :class_groups, :class_group_enrollments]).all
      render 'new'  
    end

    def enroll_student
      if params[:student_ids] && params[:student_ids] != ""
        student_ids = params[:student_ids].split(",")
        @class_group = ClassGroup.find(params[:class_group_enrollment][:class_group_id])
        @students = []

        student_ids.each {|student_id|
          student = Student.find(student_id)
          class_group_enrollment = ClassGroupEnrollment.new(:class_group_id => params[:class_group_enrollment][:class_group_id], :student_id => student.id)
          # handle not saving course enrollment
          class_group_enrollment.save!
          @students << class_group_enrollment.student
        }
        respond_to do |format|
          format.js { render 'enroll_student' }
        end

      end
    end

     def destroy
      @class_group_enrollment = ClassGroupEnrollment.find(params[:class_group_enrollment])
      @class_group = ClassGroup.find(@class_group_enrollment.class_group_id)
      @class_group_enrollment.destroy
      respond_to do |format|
        format.js { render 'destroy' }
      end
    end

  end
end