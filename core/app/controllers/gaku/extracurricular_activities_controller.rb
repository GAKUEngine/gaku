module Gaku
  class ExtracurricularActivitiesController < GakuController

    inherit_resources
    respond_to :js, :html

    before_filter :count, :only => [:create, :destroy, :index]
    before_filter :extracurricular_activity, :only => :student_chooser

    def student_chooser
      @search = Student.search(params[:q])
      @students = @search.result

      @extracurricular_activities = ExtracurricularActivity.all

      @enrolled_students = @extracurricular_activity.students.map {|i| i.id.to_s }

      params[:selected_students].nil? ? @selected_students = [] : @selected_students = params[:selected_students]

      respond_to do |format|
        format.js
      end
    end

    private

    def count
      @count = ExtracurricularActivity.count
    end

    def extracurricular_activity
      @extracurricular_activity = ExtracurricularActivity.find(params[:id])
    end

  end
end
