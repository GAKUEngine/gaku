module Gaku
  class Exams::ExamPortionsController < GakuController

    authorize_resource class: false

    respond_to :js, :html

    before_action :set_exam, only: %i( new show create edit update destroy sort index )
    before_action :set_exam_portion, only: %i( show edit update destroy )

    def index
    end

    def new
      @exam_portion = ExamPortion.new
      respond_with @exam_portion
    end

    def create
      @exam_portion = @exam.exam_portions.create(exam_portion_params)
      set_count
      respond_with @exam_portion
    end

    def show
      respond_with @exam_portion
    end

    def edit
      respond_with @exam_portion
    end

    def update
      @exam_portion.update(exam_portion_params)
      respond_with @exam_portion#, location: [@exam, :exam_portions]
    end

    def destroy
      @exam_portion.destroy
      # if @exam.exam_portions.empty?
      #   if @exam.destroy!
      #     flash[:notice] = t(:'notice.destroyed', resource: t(:'exam.singular'))
      #   end
      # end
      set_count
      respond_with @exam_portion
    end

    def sort
      params[:'exam-portion'].each_with_index do |id, index|
        @exam.exam_portions.update_all({ position: index }, { id: id })
      end
      render nothing: true
    end

    private

    def exam_portion_params
      params.require(:exam_portion).permit(attributes)
    end


    def attributes
      %i( name weight problem_count max_score description adjustments )
    end

    def set_exam_portion
      @exam_portion = ExamPortion.find(params[:id])
    end

    def set_exam
      @exam = Exam.find(params[:exam_id])
    end

    def set_count
      @count = @exam.reload.exam_portions_count
    end
  end
end
