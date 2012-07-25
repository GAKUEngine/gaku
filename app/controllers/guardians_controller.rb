class GuardiansController < ApplicationController

  #before_filter :authenticate_user!

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  belongs_to :student
  
  def destroy
    destroy! :flash => !request.xhr?
  end

  def new_contact
  	@student = Student.find(params[:student_id])
  	@guardian = Guardian.find(params[:id])
  	@contact = Contact.new
  
  	respond_to do |format|
  		format.js {render 'new_contact'}
  	end
  end

  
end

