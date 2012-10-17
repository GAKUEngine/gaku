class ClassGroups::SemestersController < ApplicationController

  inherit_resources
  actions :index, :show, :new, :create, :update, :edit, :destroy

  respond_to :js, :html

  before_filter :load_class_group, :only => [:new, :create, :edit, :update, :destroy]
  
  def create
    super do |format|
      @class_group.semesters << @semester
      format.js { render 'create' }  
    end 
  end
  
  private 
    def load_class_group
      @class_group = ClassGroup.find(params[:class_group_id])
    end

end