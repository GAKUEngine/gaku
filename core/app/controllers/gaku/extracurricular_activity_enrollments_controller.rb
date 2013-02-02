module Gaku
  class ExtracurricularActivityEnrollmentsController < GakuController

    include Enrollments

    def autocomplete_filtered_students
      @enrolled_students = ExtracurricularActivityEnrollment.where(:extracurricular_activity_id => params[:extracurricular_activity_id]).pluck(:student_id)

      if @enrolled_students.blank?
        @students = Student.includes([:addresses, :extracurricular_activities, :extracurricular_activity_enrollments])
                           .where('(surname || " " || name LIKE ?) OR (name || " " || surname LIKE ?)', "%#{params[:term]}%", "%#{params[:term]}%")
      else
        @students = Student.includes([:addresses, :extracurricular_activities, :extracurricular_activity_enrollments])
                          .where('id not in (?)) and ((surname || " " || name LIKE ?) OR (name || " " || surname LIKE ?)',@class_group_enrolled_students ,"%#{params[:term]}%", "%#{params[:term]}%" )
      end

      render json: @students.as_json(:methods => [:address_widget])
    end

  end
end
