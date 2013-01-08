module Gaku
  class Exams::ExamPortionsController < GakuController

    inherit_resources
    belongs_to :exam
    respond_to :js, :html

    before_filter :exam
    before_filter :count, :only => [:create, :destroy]


    def destroy
      super do |format|
        if @exam.exam_portions.empty?
          if @exam.destroy
            flash[:notice] = t(:'notice.destroyed', :resource => t(:'exam.singular'))
          end
        end
        format.js { render }
      end
    end

    def sort
      params[:exam_portion].each_with_index do |id, index|
        @exam.exam_portions.update_all( {:position => index}, {:id => id} )
      end
      render :nothing => true
    end

    private

    def exam
      @exam = Exam.find(params[:exam_id])
    end

    def count
      @count = @exam.exam_portions.count
    end
  end
end
