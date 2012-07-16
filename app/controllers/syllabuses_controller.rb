class SyllabusesController < ApplicationController

  #before_filter :authenticate_user!

  before_filter :load_syllabus, :only  => [:new_exam, :new_assignment]

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  def destroy
    destroy! :flash => !request.xhr?
  end

  def new_exam
  	@syllabus.exams.build
  end

  def new_assignment
    @syllabus.assignments.build
  end

  private
    def load_syllabus 
    	@syllabus = Syllabus.find(params[:id])
    end
  
end