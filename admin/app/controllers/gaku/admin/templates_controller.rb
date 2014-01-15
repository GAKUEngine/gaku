module Gaku
  module Admin
    class TemplatesController < Admin::BaseController

      responders :collection

      respond_to :js,   only: %i( destroy )
      respond_to :html, only: %i( new edit index update create )

      before_action :set_template, only: %i( download edit update destroy )

      def new
        @template = Template.new
      end

      def create
        @template = Template.new(template_params)
        if @template.save
          set_count
          respond_with @template, location: admin_templates_path
        else
          render :new
        end
      end

      def edit
        respond_with @template
      end

      def update
        @template.update(template_params)
        respond_with @template, location: admin_templates_path
      end

      def download
        send_file @template.file.path
      end

      def index
        @templates = Template.all
        set_count
        respond_with @templates
      end

      def destroy
        @template.destroy
        set_count
        respond_with @template
      end

      private

      def set_count
        @count = Template.count
      end

      def set_template
        @template = Template.find(params[:id])
      end

      def template_params
        params.require(:template).permit(attributes)
      end

      def attributes
        %i( name context locked file )
      end

    end

  end
end
