class SyllabusesController < ApplicationController

  before_filter :load_before_index, :only => :index
  before_filter :syllabus, :only  => :show
  before_filter :load_before_show, :only => :show

  inherit_resources
  actions :index, :show, :new, :create, :update, :edit, :destroy

  respond_to :js, :html

  def create
    super do |format|
      format.js { render }
    end
  end

  def destroy
    super do |format|
      format.js { render :nothing => true }
    end
  end

  private
    def load_before_index
      @syllabus = Syllabus.new
    end

    def syllabus 
    	@syllabus = Syllabus.find(params[:id])
    end

    def load_before_show
      @exam = Exam.new
      @exam.exam_portions.build
      @syllabus.assignments.build
    end

end
