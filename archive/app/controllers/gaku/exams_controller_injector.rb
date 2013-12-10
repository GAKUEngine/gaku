module Gaku
  ExamsController.class_eval do

    def recovery
      @exam = Exam.deleted.find(params[:id])
      @exam.recover
      respond_with @exam
    end

    def soft_delete
      @exam = Exam.find(params[:id])
      @exam.soft_delete
      respond_with @exam, location: exams_path
    end

  end
end
