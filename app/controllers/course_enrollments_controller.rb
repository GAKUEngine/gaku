class CourseEnrollmentsController < ApplicationController

  inherit_resources

  actions :show, :new, :create, :update, :edit, :destroy
  
  def create
  raise  request.to_json
    super do |format|
      format.js {render 'create'}
    end  
  end

end
