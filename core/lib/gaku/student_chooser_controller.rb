module Gaku
  module StudentChooserController

    include Core::ClassNameDetector

    def student_chooser
      @search = Student.search(params[:q])
      @students = @search.result.page(params[:page]).per(Preset.students_per_page)


      instance_variable_set("@#{class_name_underscored_plural}", class_name.constantize.all)
      #@class_groups = class_name.constantize.all

      instance_variable_set("@#{class_name_underscored}", class_name.constantize.find(params[:id]))
      #@class_group = class_name.constantize.find(params[:id])

      @enrolled_students = instance_variable_get("@#{class_name_underscored}").students.map {|i| i.id.to_s }
      #@enrolled_students = @class_group.students.map {|i| i.id.to_s }

      params[:selected_students].nil? ? @selected_students = [] : @selected_students = params[:selected_students]

      respond_to do |format|
        format.js
      end
    end

  end
end
