module Gaku
  TeachersController.class_eval do

    def recovery
      @teacher = Teacher.deleted.find(params[:id])
      @teacher.recover
      respond_with @teacher
    end

    def soft_delete
      @teacher = Teacher.find(params[:id])
      @teacher.soft_delete
      respond_with @teacher, location: teachers_path
    end

  end
end
