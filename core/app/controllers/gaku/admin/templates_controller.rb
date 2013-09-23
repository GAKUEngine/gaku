module Gaku
  module Admin
    class TemplatesController < Admin::BaseController

      load_and_authorize_resource class: Template

      respond_to :js, :html

      inherit_resources

      before_action :count, only: %i(create destroy index)

      def create
        super do |format|
          format.html { redirect_to :back }
        end
      end

      def update
        super do |format|
          format.html { redirect_to :back }
        end
      end

      def download
        @template = Template.find(params[:id])
        send_file @template.file.path
      end

      protected

      def resource_params
        return [] if request.get?
        [params.require(:template).permit(attributes)]
      end

      private

      def count
        @count = Template.count
      end

      def attributes
        %i(name context locked file)
      end

    end
  end
end
