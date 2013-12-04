module Gaku
  SyllabusesController.class_eval do

    def recovery
      @syllabus = Syllabus.deleted.find(params[:id])
      @syllabus.recover
      respond_with @syllabus
    end

    def soft_delete
      @syllabus = Syllabus.find(params[:id])
      @syllabus.soft_delete
      respond_with @syllabus, location: syllabuses_path
    end

  end
end
