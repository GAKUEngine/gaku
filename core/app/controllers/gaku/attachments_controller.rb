module Gaku
  class AttachmentsController < GakuController

    inherit_resources
    actions :index, :show, :new, :create, :update, :edit, :destroy
    before_filter :unscoped_attachment, only: [:recovery, :destroy]
    respond_to :js, :html

    # TODO: merge and refactor two controllers
    def create
      @attachable = find_attachable
      @attachment = @attachable.attachments.build(params[:attachment])
      respond_to do |format|
        if @attachment.save
          format.html { redirect_to :back, flash: { notice: 'Asset upload was successful!' } }
        else
          format.html { redirect_to :back, flash: {success: 'Error when upload asset'} }
        end
      end
    end

    def update
      super do |format|
        format.html { redirect_to :back }
      end
    end

    def new
      @note = @attachable.attachment.new
    end

    def destroy
      super do |format|
        format.js { render :destroy }
      end
    end

    def soft_delete
      @attachment = Attachment.find(params[:id])
      @attachment.update_attribute(:deleted, true)
      flash.now[:notice] = t(:'notice.destroyed', resource: t(:'attachment.singular'))
      respond_to do |format|
        format.js { render :soft_delete }
      end
    end

    def download
      @attachment = Attachment.find(params[:id])
      send_file @attachment.asset.path
    end

    def recovery
      @attachment.update_attribute(:deleted, false)
      flash.now[:notice] = t(:'attachment.attachment_recovered')

      respond_to do |format|
        format.js { render :recover_attachment }
      end
    end

    def resource_params
      return [] if request.get?
      [params.require(:attachment).permit(attachment_attr)]
    end

    private

    def attachment_attr
      [:name, :description, :asset]
    end

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
