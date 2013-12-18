module Gaku
  class Exams::ExamPortions::AttachmentsController < GakuController

    respond_to :js, :html

    before_action :set_exam, only: [:new, :create]
    before_action :set_exam_portion, only: [:new, :create,  :index]

    def new
      @attachment = Attachment.new
      respond_with @attachment
    end


    def create
      @attachment = @exam_portion.attachments.create(attachment_params)
      set_count
      respond_with @attachment, location: [:edit, @exam, @exam_portion]
    end

    protected

    def attachment_params
      params.require(:attachment).permit(attributes)
    end

    private

    def attributes
      [:name, :description, :asset]
    end


    def set_exam
      @exam = Exam.find(params[:exam_id])
    end

    def set_exam_portion
      @exam_portion = ExamPortion.find(params[:id] || params[:exam_portion_id])
    end

    def set_count
      @count = @exam_portion.attachments.count
    end
  end
end
