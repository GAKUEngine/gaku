module Gaku
  class Exams::ExamPortionsController < GakuController

    inherit_resources
    actions :index, :show, :new, :create, :update, :edit, :destroy
    belongs_to :exam

    respond_to :js, :html

    before_filter :exam
    before_filter :count, :only => [:create, :destroy]

    private

    def exam
      @exam = Exam.find(params[:exam_id])
    end

    def count
      @count = @exam.exam_portions.count
    end
  end
end
