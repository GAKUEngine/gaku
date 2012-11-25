module Gaku
  class ExamPortionsController < GakuController

    inherit_resources
    actions :index, :show, :new, :create, :update, :edit, :destroy

    respond_to :js, :html

    before_filter :exam, :only => [:show, :edit, :update, :destroy ]
    before_filter :portions_count, :only => :destroy
    def new
      super do |format|
        format.js { render 'gaku/exams/exam_portions/new' }
      end
    end

    def show
      @attachment = Attachment.new
      super do |format|
        format.html { render 'gaku/exams/exam_portions/show' }
      end
    end

    def edit
      super do |format|
        format.js { render 'gaku/exams/exam_portions/edit' }
      end
    end

    def update
      super do |format|
        format.js { render 'gaku/exams/exam_portions/update' }
      end
    end

    def destroy
      @exam_portion = ExamPortion.find(params[:id])
      @portion_id = @exam_portion.id
      @exam_portion.destroy
      @total_weight = get_total_weight(@exam.exam_portions)
      super do |format|
        format.js { render 'gaku/exams/exam_portions/destroy' }
      end
    end

    private
      def exam
        @exam = Exam.find(params[:exam_id])
      end

      def get_total_weight(portions)
        total = 0
        portions.each do |portion|
          total+=portion.weight
        end
        total
      end

      def portions_count
        exam
        @portions_count = @exam.exam_portions.count
      end
  end
end
