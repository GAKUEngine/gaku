module Gaku
  class GradingMethodConnectorsController < Gaku::GakuController

    respond_to :js

    before_action :load_gradable
    before_action :set_grading_method_connector, only: %i( destroy )
    before_action :load_data, only: %i( new )
    before_action :load_sets, only: %i( new_set )

    def index

    end

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

    def new_set
      @grading_method_connector = @gradable.grading_method_connectors.new
      respond_with @grading_method_connectors
    end

    def add_set
      if params[:grading_method_set_id].present?
        add_not_included_grading_methods
        set_flash
      end
      set_count
      render :add_set
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

    def load_sets
      @grading_method_sets = Gaku::GradingMethodSet.all
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

    def set_flash
      flash.now[:notice] = if @grading_method_connectors.any?
        t(:'grading_method_connector.add_set')
      else
        t(:'grading_method_connector.already')
      end
    end

    def add_not_included_grading_methods
      @grading_method_set = Gaku::GradingMethodSet.find(params[:grading_method_set_id])

      #remove methods that are already in gradable grading methods collection
      not_included_grading_methods = @grading_method_set.grading_methods - @gradable.grading_methods

      #get join model records for view appending
      @grading_method_connectors = not_included_grading_methods.map do |method|
        @gradable.grading_method_connectors.create(grading_method: method)
      end

    end

  end
end
