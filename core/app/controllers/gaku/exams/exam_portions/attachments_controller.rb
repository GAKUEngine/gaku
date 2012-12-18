module Gaku
	class Exams::ExamPortions::AttachmentsController < GakuController
		respond_to :js, :html
		inherit_resources
		actions :index, :show, :new, :create, :update, :edit, :destroy

		before_filter :exam, :only => [:new, :create]
		before_filter :exam_portion, :only => [:new, :create,  :index]
		before_filter :count, :only => :index


		def create
			@attachment = @exam_portion.attachments.build(params[:attachment])
			respond_to do |format|
				if @attachment.save
					format.html { redirect_to [@exam, @exam_portion], :notice => t(:'notice.uploaded', :resource => t(:'attachment.singular') ) }
				else
					format.html { redirect_to [@exam, @exam_portion], :flash => {:error => t(:'errors.not_uploaded', :resource => t(:'attachment.singular')) } }
				end
			end
		end

		private

		def exam
			@exam = Exam.find(params[:exam_id])
		end

		def exam_portion
			@exam_portion = ExamPortion.find(params[:id] || params[:exam_portion_id])
		end

	  def count
    	@count = @exam_portion.attachments.count
    end
	end
end