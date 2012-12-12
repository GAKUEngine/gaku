module Gaku
  class Exams::ExamPortionsController < GakuController

    inherit_resources
    actions :index, :show, :new, :create, :update, :edit, :destroy

    respond_to :js, :html

    before_filter :exam
    before_filter :count, :only => [:create, :destroy]

    def create
      @exam_portion = @exam.exam_portions.build(params[:exam_portion])
      if @exam_portion.save
        respond_with @exam_portion
      end
    end


    def destroy
      @exam_portion = ExamPortion.find(params[:id])
      @portion_id = @exam_portion.id
      @exam_portion.destroy
      @total_weight = get_total_weight(@exam.exam_portions)
      super do |format|
        format.js { render 'destroy' }
      end
    end

    private

      def exam
        @exam = Exam.find(params[:exam_id])
      end

      def get_total_weight(portions)
        portions.inject(0) {|sum, p| sum + p.weight }
      end

      def count
        @count = @exam.exam_portions.count
      end
  end
end
