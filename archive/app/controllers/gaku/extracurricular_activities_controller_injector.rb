module Gaku
  ExtracurricularActivitiesController.class_eval do

    include TrashableController

    before_action :set_resource,         only: :soft_delete
    before_action :set_deleted_resource, only: :recovery

    private

    def set_resource
      @resource = ExtracurricularActivity.find(params[:id])
    end

    def set_deleted_resource
      @resource = ExtracurricularActivity.deleted.find(params[:id])
    end

  end
end
