module Gaku
  ClassGroupsController.class_eval do

    def recovery
      @class_group = ClassGroup.deleted.find(params[:id])
      @class_group.recover
      respond_with @class_group
    end

    def soft_delete
      @class_group = ClassGroup.find(params[:id])
      @class_group.soft_delete
      respond_with @class_group, location: class_groups_path
    end

  end
end
