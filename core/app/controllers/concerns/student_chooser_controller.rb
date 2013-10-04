module StudentChooserController

  include Gaku::ClassNameDetector

  def student_chooser
    set_enrollment_statuses
    set_countries
    set_students

    set_collection
    set_resource

    respond_to { |format| format.js }
  end

  private

  def set_countries
    @countries = Gaku::Country.all.sort_by(&:name).map{|s| [s.name, s.id]}
  end

  def set_enrollment_statuses
    @enrollment_status_applicant_code = Gaku::EnrollmentStatus.where(code: 'applicant').first_or_create.code
    @enrollment_status_enrolled_code = Gaku::EnrollmentStatus.where(code: 'enrolled').first_or_create.code
    @enrollment_statuses =  Gaku::EnrollmentStatus.all.map { |es| [es.name, es.code] }
    @enrollment_statuses << [t('undefined'), nil]
  end

  def set_students
    active_enrollment_statuses_codes = Gaku::EnrollmentStatus.active.pluck(:code)
    @search = Gaku::Student.search(params[:q])
    @students = @search.result.where(enrollment_status_code: active_enrollment_statuses_codes)
                              .page(params[:page])
                              .per(Gaku::Preset.students_per_page)

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
