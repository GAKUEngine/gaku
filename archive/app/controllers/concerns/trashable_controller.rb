module TrashableController

  extend ActiveSupport::Concern
  include Gaku::ClassNameDetector

  included do

    before_action :set_resource,         only: :soft_delete
    before_action :set_deleted_resource, only: :recovery

    def recovery
      @resource.recover
      respond_with instance_variable_set("@#{class_name_underscored}", @resource)
    end

    def soft_delete
      @resource.soft_delete
      respond_with instance_variable_set("@#{class_name_underscored}", @resource),
                   location: "/#{class_name_underscored_plural}"
    end

    private

    def set_resource
      @resource = class_name.constantize.find(params[:id])
    end

    def set_deleted_resource
      @resource = class_name.constantize.deleted.find(params[:id])
    end

  end
end
