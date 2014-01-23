module StudentChooserController

  include Gaku::ClassNameDetector

  def student_chooser
    set_students

    set_collection
    set_resource

    respond_to { |format| format.js }
  end

  private

  def set_students
    @search = Gaku::Student.active.search(params[:q])
    @students = @search.result.page(params[:page])

    params[:selected_students].nil? ? @selected_students = [] : @selected_students = params[:selected_students]

    # Example: @enrolled_students = @class_group.students.map {|i| i.id.to_s }
    @enrolled_students = instance_variable_get("@#{class_name_underscored}").students.map {|i| i.id.to_s }
  end

  def set_collection
    # Example: @class_groups = class_name.constantize.all
    instance_variable_set("@#{class_name_underscored_plural}", class_name.constantize.all)
  end

  def set_resource
    # Example: @class_group = class_name.constantize.find(params[:id])
    instance_variable_set("@#{class_name_underscored}", class_name.constantize.find(params[:id]))
  end

end
