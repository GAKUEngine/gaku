module Gaku
  class GradingMethodConnectorsController < Gaku::GakuController

    respond_to :js

    before_action :load_gradable
    before_action :set_grading_method_connector, only: %i( destroy )
    before_action :load_data, only: %i( new )

    def new
     @grading_method_connector = @gradable.grading_method_connectors.new
     respond_with @grading_method_connector
    end

    def create
      @grading_method_connector = @gradable.grading_method_connectors.create(grading_method_connector_params)
      set_count
      respond_with @grading_method_connector
    end

    def destroy
      @grading_method_connector.destroy!
      set_count

      respond_with @grading_method_connector
    end

    def sort
      params["grading-method-connector"].each_with_index do |id, index|
        @gradable.grading_method_connectors.where(id: id).update_all(position: index)
      end

      render nothing: true
    end


    private

    def grading_method_connector_params
      params.require(:grading_method_connector).permit(attrs)
    end

    def attrs
      %i( grading_method_id )
    end

    def load_data
      @grading_methods = Gaku::GradingMethod.all
    end

    def set_grading_method_connector
      @grading_method_connector = Gaku::GradingMethodConnector.find(params[:id])
    end

    def load_gradable
      resource, id = request.path.split('/')[1,2]
      @gradable = resource.insert(0, 'gaku/').pluralize.classify.constantize.find(id)
      @gradable_resource = @gradable.class.to_s.demodulize.underscore.dasherize
    end

    def set_count
      @count = @gradable.grading_method_connectors.count
    end

  end
end
