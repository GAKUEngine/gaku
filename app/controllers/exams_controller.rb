class ExamsController < ApplicationController

  #before_filter :authenticate_user!

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy


  def available
    @exams = Exam.order('name asc')
    respond_with(@exams) do |format|
      format.html { render :layout => !request.xhr? }
      format.js
    end
  end

  def select
    @exam ||= Exam.find(params[:id])
  end

  def destroy
    destroy! :flash => !request.xhr?
  end
  
end