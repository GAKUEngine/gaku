class StudentsController < ApplicationController

  #before_filter :authenticate_user!

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  def destroy
    destroy! :flash => !request.xhr?
  end

  def new
  	@student = Student.new
  	@class_groups = ClassGroup.all
  	@class_group_id = params[:class_group_id].nil? ? 'nil' : params[:class_group_id]
  end
  
end
