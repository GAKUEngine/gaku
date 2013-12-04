module Gaku
  StudentsController.class_eval do

    def recovery
      @student = Student.deleted.find(params[:id])
      @student.recover
      respond_with @student
    end

    def soft_delete
      @student = Student.find(params[:id])
      @student.soft_delete
      respond_with @student, location: students_path
    end

  end
end
