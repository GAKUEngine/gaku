module Gaku
  class Exams::ExamPortionsController < GakuController

    authorize_resource class: false

    respond_to :js, :html

    before_action :set_exam, only: %i( new show create edit update destroy sort index )
    before_action :set_exam_portion, only: %i( show edit update destroy )
    before_action :set_attachable, only: %i( edit )

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
      #if params doesnt exist that mean options are removed
      @exam_portion.update_attribute(:score_selection_options, nil) unless score_selection_options?
      respond_with @exam_portion
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
      [ :name, :weight, :problem_count, :max_score, :description, :adjustments, :score_type, score_selection_options: [] ]
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

    def set_attachable
      @attachable = @exam_portion
      @attachable_resource = 'exam-exam-portion-attachment'
    end

    def score_selection_options?
      not params[:exam_portion][:score_selection_options].blank?
    end
  end
end
