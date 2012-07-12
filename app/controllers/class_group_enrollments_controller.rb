class ClassGroupEnrollmentsController < ApplicationController

  inherit_resources

  actions :show, :new, :create, :update, :edit, :destroy

  def create
    super do |format|
      format.js {render 'create'}
    end  
  end
  
end