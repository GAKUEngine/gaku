module TrashableController

  extend ActiveSupport::Concern
  include Gaku::ClassNameDetector

  def recovery
    @resource.recover
    respond_with instance_variable_set("@#{class_name_underscored}", @resource)
  end

  def soft_delete
    @resource.soft_delete
    respond_with instance_variable_set("@#{class_name_underscored}", @resource), location: "/#{class_name_underscored_plural}"
  end

end
