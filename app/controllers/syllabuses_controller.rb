class SyllabusesController < ApplicationController

  before_filter :syllabus, :only  => :show
  before_filter :load_before_show, :only => :show

  inherit_resources
  actions :index, :show, :new, :create, :update, :edit, :destroy

  respond_to :js, :html

  private
    def syllabus 
    	@syllabus = Syllabus.find(params[:id])
    end

    def load_before_show
      @exam = Exam.new
      @exam.exam_portions.build
      @syllabus.assignments.build
      @notable = @syllabus
    end

end
