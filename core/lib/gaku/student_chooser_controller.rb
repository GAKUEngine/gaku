module Gaku
  module StudentChooserController

    include Core::ClassNameDetector

    def student_chooser
      @enrollment_status_applicant_code = EnrollmentStatus.first_or_create(code: 'applicant').code
      @enrollment_status_enrolled_code = EnrollmentStatus.first_or_create(code: 'enrolled').code
      

      active_enrollment_statuses_codes = Gaku::EnrollmentStatus.active.pluck(:code)
      @search = Student.search(params[:q])
      @students = @search.result.where(enrollment_status_code: active_enrollment_statuses_codes).page(params[:page]).per(Preset.students_per_page)

      @countries = Gaku::Country.all.sort_by(&:name).collect{|s| [s.name, s.id]}
      @enrollment_statuses =  EnrollmentStatus.all.collect { |es| [es.name, es.id] }
      @enrollment_statuses << [t('undefined'), nil]

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
