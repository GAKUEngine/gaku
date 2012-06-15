class StudentsController < ApplicationController

  #before_filter :authenticate_user!

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  before_filter :load_class_groups, :only => [:new, :edit]

  def destroy
    destroy! :flash => !request.xhr?
  end

  private

    def load_class_groups
      @class_groups = ClassGroup.all
  	  @class_group_id = params[:class_group_id].nil? ? 'nil' : params[:class_group_id]
    end

end
