class ClassGroupEnrollmentsController < ApplicationController

  def filtered_students
    @class_group_enrolled_students = ClassGroupEnrollment.where(:class_group_id => params[:class_group_id]).pluck(:student_id)
   
    if @class_group_enrolled_students.blank?
      @students = Student.find(:all, :include => [:addresses, :class_groups, :class_group_enrollments])
    else 
      @students = Student.find(:all, :conditions => ['id not in (?)', @class_group_enrolled_students], :include => [:addresses, :class_groups, :class_group_enrollments])
    end

    @students_json = @students.as_json(:methods => [:address_widget, :class_group_widget,:seat_number_widget])
    i = 0
    @students_json.each {|student|
      student[:name] = @students[i].name
      student[:surname] = @students[i].surname
      student[:phone] = @students[i].phone
      i += 1
    }

    respond_to do |format|
      format.json { render :json => @students_json.as_json }
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
