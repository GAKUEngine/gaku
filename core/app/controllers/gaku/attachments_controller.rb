module Gaku
	class AttachmentsController < GakuController

		inherit_resources
		actions :index, :show, :new, :create, :update, :edit, :destroy
		before_filter :unscoped_attachment, :only => [:recovery, :destroy]

		def create
			@attachable = find_attachable
			@attachment = @attachable.attachments.build(params[:attachment])
			respond_to do |format|
			if @attachment.save
					format.html { redirect_to :back, :notice => 'Asset upload was successful!' }
				else
					format.html { redirect_to :back, :flash => {:success => 'Error when upload asset'} }
				end
			end
		end

		def new
			@note = @attachable.attachment.new
		end

		def destroy
			super do |format|
				format.js { render 'destroy' }
			end
		end

		def soft_delete
			@attachment = Attachment.find(params[:id])
			@attachment.update_attribute(:is_deleted, true)
			render :nothing => true
		end

		def download
			@attachment = Attachment.find(params[:id])
			send_file @attachment.asset.path
		end

		def recovery
			@attachment.update_attribute(:is_deleted, false)
			flash.now[:notice] = t('notice.recovered', :resource => t('attachment.singular'))
			respond_to do |format|
				format.js { render 'recover_attachment'}
			end
		end

		private

			def unscoped_attachment
				@attachment = Attachment.unscoped.find(params[:id])
			end

		  def find_attachable
	      # unnamespaced_klass = ''
	      # klass = [Gaku::Student, Gaku::LessonPlan, Gaku::Syllabus, Gaku::ClassGroup, Gaku::Course, Gaku::Exam].detect do |c|
	      #   unnamespaced_klass = c.to_s.split("::")
	      #   params["#{unnamespaced_klass[1].underscore}_id"]
	      # end

	      # @notable = klass.find(params["#{unnamespaced_klass[1].underscore}_id"])
	      # @notable_resource = @notable.class.to_s.underscore.split('/')[1].gsub("_","-")
		  end

	end
end