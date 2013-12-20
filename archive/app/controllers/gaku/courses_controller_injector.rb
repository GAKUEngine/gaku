module Gaku
  CoursesController.class_eval do

    include TrashableController

    before_action :set_resource,         only: :soft_delete
    before_action :set_deleted_resource, only: :recovery

    private

    def set_resource
      @resource = Course.includes(syllabus: {exams: :exam_portion_scores}).find(params[:id])
    end

    def set_deleted_resource
      @resource = Course.deleted.includes(syllabus: {exams: :exam_portion_scores}).find(params[:id])
    end

  end
end
