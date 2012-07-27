class ExamPortionScoresController < ApplicationController
  inherit_resources
  actions :new, :index, :create, :update, :edit, :destroy

  def index
    if !(params.has_key?(:course_id) && params.has_key?(:exam_id))
      render :text => "No Course Specified"
      return
    end
    render :text => "has course" << Course.find(params[:course]).syllabus.name
  end
end
