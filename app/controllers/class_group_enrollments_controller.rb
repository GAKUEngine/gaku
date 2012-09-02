class ClassGroupEnrollmentsController < ApplicationController

  inherit_resources

  actions :show, :new, :create, :update, :edit, :destroy

  def create
    super do |format|
      format.js { render 'create' }
    end  
  end

  def new
    
    @class_group = ClassGroup.find(params[:class_group_id])
    enrolled_students_ids = ClassGroupEnrollment.where(:class_group_id => @class_group.id).map {|x| x.student_id}
    @class_group_enrollment = ClassGroupEnrollment.new
    @students = Student.includes([:addresses, :class_groups, :class_group_enrollments]).all

    super do |format|
      format.js {render 'new'}  
    end  
  end

  # creating class_enrollment from students/show
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
    @class_group_enrollment = ClassGroupEnrollment.find(params[:id])
    @class_group = ClassGroup.find(@class_group_enrollment.class_group_id)
    @class_group_enrollment.destroy
    respond_to do |format|
      format.js { render 'class_groups/enrollments/destroy' }
    end
  end

  def filtered_students
    @class_group_enrolled_students = ClassGroupEnrollment.where(:class_group_id => params[:class_group_id]).pluck(:student_id)
    if @class_group_enrolled_students.blank?
      @students = Student.find(:all, :include => [:addresses, :class_groups, :class_group_enrollments])
    else 
      @students = Student.find(:all, :conditions => ['id not in (?)', @class_group_enrolled_students], :include => [:addresses, :class_groups, :class_group_enrollments])
    end
    respond_to do |format|
      format.json { render :json => @students.as_json(:methods => [:address_widget, :class_group_widget,:seat_number_widget])}
    end
  end

  def autocomplete_filtered_students
    @class_group_enrolled_students = ClassGroupEnrollment.where(:class_group_id => params[:class_group_id]).pluck(:student_id)
    if @class_group_enrolled_students.blank?
      @students = Student.includes([:addresses, :class_groups, :class_group_enrollments])
                         .where('(surname || " " || name LIKE ?) OR (name || " " || surname LIKE ?)', "%#{params[:term]}%", "%#{params[:term]}%")
    else
      @students = Student.includes([:addresses, :class_groups, :class_group_enrollments])
                          .where('id not in (?)) and ((surname || " " || name LIKE ?) OR (name || " " || surname LIKE ?)',@class_group_enrolled_students ,"%#{params[:term]}%", "%#{params[:term]}%" )
    end
    
    render json: @students.as_json(:methods => [:address_widget, :class_group_widget,:seat_number_widget]) 
  
  end


end