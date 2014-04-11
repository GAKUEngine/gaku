module AdminPictureController

  include Gaku::ClassNameDetector

  def set_picture
    @resource = set_resource
    @resource.update params.require(param_name).permit(:picture)
    flash.now[:notice] = t('notice.picture_update')
    render 'gaku/admin/shared/set_picture'
  end

  def remove_picture
    @resource = set_resource
    @resource.update(picture: nil)
    flash.now[:notice] = t('notice.picture_remove')
    render 'gaku/admin/shared/remove_picture'
  end

  private

  def set_resource
    instance_variable_set("@#{class_name_underscored}", class_name.constantize.find(params[:id]))
  end

  def param_name
    controller_name.singularize.to_sym
  end

end
