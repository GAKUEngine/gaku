class Students::GuardiansController < ApplicationController

  #before_filter :authenticate_user!

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  def new
    @guardian = Guardian.new

    respond_to do |format|
      format.html {render :partial => "students/new_guardian"}
      format.json {render :json => @guardian}
    end
  end

  def destroy
    destroy! :flash => !request.xhr?
  end
  
end

