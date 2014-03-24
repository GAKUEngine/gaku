module PictureController

  include Gaku::ClassNameDetector

  def set_picture
    @resource = set_resource
    @resource.update params.require(:student).permit(:picture)
    flash.now[:notice] = t('notice.image_update')
    render 'gaku/shared/js/set_picture'
  end

  private

  def set_resource
    instance_variable_set("@#{class_name_underscored}", class_name.constantize.find(params[:id]))
  end

end
