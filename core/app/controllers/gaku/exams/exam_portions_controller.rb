module Gaku
  class Exams::ExamPortionsController < GakuController

    inherit_resources
    respond_to :js, :html

    before_filter :exam, :except => [:new, :create]
    before_filter :portions_count, :only => :destroy
    before_filter :attachments_count, :only => :show

    def show
      @attachment = Attachment.new
      show!
    end

    def destroy
      @exam_portion = ExamPortion.find(params[:id])
      @portion_id = @exam_portion.id
      @exam_portion.destroy
      @total_weight = get_total_weight(@exam.exam_portions)

      destroy!
    end

    private
      def exam
        @exam = Exam.find(params[:exam_id])
      end

      def get_total_weight(portions)
        total = 0
        portions.each do |portion|
          total += portion.weight
        end
        total
      end

      def portions_count
        exam
        @portions_count = @exam.exam_portions.count
      end

      def exam_portion
        @exam_portion = ExamPortion.find(params[:id])
      end

      def attachments_count
        @exam_portion = ExamPortion.find(params[:id])
        @attachments_count = @exam_portion.attachments.count
      end
  end
end
