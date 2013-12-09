module Gaku
  class AttachmentsController < GakuController

    before_action :set_attachment, only: %i( show edit update soft_delete download )
    before_action :set_unscoped_attachment, only: %i( recovery destroy )
    respond_to :js, :html

    # TODO: merge and refactor two controllers

    def new
      @attachment = Attachment.new
      respond_with @attachment
    end


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

    def edit
      respond_with @attachment
    end

    def update
      @attachment.update(attachment_params)
      respond_with(@attachment) do |format|
        format.html { redirect_to :back }
      end
    end

    def destroy
      @attachment.destroy!
      respond_with @attachment
    end

    def soft_delete
      @attachment.soft_delete
      respond_with @attachment
    end

    def download
      @attachment = Attachment.find(params[:id])
      send_file @attachment.asset.path
    end

    def recovery
      @attachment.recover
      respond_with @attachment
    end

    def attachment_params
      params.require(:attachment).permit(attachment_attr)
    end

    private


    def attachment_attr
      [:name, :description, :asset]
    end

    def set_attachment
      @attachment = Attachment.find(params[:id])
    end

    def set_unscoped_attachment
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
