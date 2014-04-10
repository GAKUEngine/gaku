module Gaku
  class SemesterConnectorsController < GakuController

    respond_to :js, only: %i( new create edit update destroy )

    before_action :set_semesterable
    before_action :set_semester_connector, only: %i( edit update destroy)
    before_action :set_semesters, only: %i( new edit )

    def new
     @semester_connector = @semesterable.semester_connectors.new
     respond_with @semester_connector
    end

    def create
      @semester_connector = @semesterable.semester_connectors.build(semester_connector_params)
      @semester_connector.save
      set_count
      respond_with @semester_connector
    end

    def edit
      respond_with @semester_connector
    end

    def update
      @semester_connector.update(semester_connector_params)
      respond_with @semester_connector
    end

    def destroy
      @semester_connector.destroy
      set_count
      respond_with @semester_connector
    end


    private

    def set_semesterable
      resource, id = request.path.split('/')[1,2]
      @semesterable = resource.insert(0, 'gaku/').pluralize.classify.constantize.find(id)
      @semesterable_resource = @semesterable.class.to_s.demodulize.underscore.dasherize
    end

    def set_semester_connector
      @semester_connector = SemesterConnector.find(params[:id])
    end

    def semester_connector_params
      params.require(:semester_connector).permit(attributes)
    end

    def attributes
      %i( semester_id )
    end

    def set_count
      @count = @semesterable.semesters.count
    end

    def set_semesters
      @semesters = Semester.all
    end

  end
end
