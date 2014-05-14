module Gaku
  class AttachmentsController < GakuController
    include PolyController

    respond_to :js, :html

    before_action :set_attachable
    before_action :set_attachment, only: %i( show edit update soft_delete download )
    before_action :set_unscoped_attachment, only: %i( recovery destroy )

    def new
      @attachment = @attachable.attachments.new
      respond_with @attachment
    end

    def create
      @attachment = @attachable.attachments.create(attachment_params)
      set_count
      respond_with @attachment
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

    private

    def attachment_params
      params.require(:attachment).permit(attachment_attr)
    end

    def attachment_attr
      [:name, :description, :asset]
    end

    def set_attachment
      @attachment = Attachment.find(params[:id])
    end

    def set_unscoped_attachment
      @attachment = Attachment.unscoped.find(params[:id])
    end

    def set_attachable
      @attachable = parent_resource
      @attachment_resource = resource_names
      @nested_resources = nested_resources
    end

    def set_count
      @count = @attachable.attachments.count
    end

  end
end
