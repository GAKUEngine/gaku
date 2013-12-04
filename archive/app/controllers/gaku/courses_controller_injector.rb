module Gaku
  CoursesController.class_eval do

    def recovery
      @course = Course.deleted.includes(syllabus: {exams: :exam_portion_scores}).find(params[:id])
      @course.recover
      respond_with @course
    end

    def soft_delete
      @course = Course.includes(syllabus: {exams: :exam_portion_scores}).find(params[:id])
      @course.soft_delete
      respond_with @course, location: courses_path
    end

  end
end
