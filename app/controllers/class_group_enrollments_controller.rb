class ClassGroupEnrollmentsController < ApplicationController

  inherit_resources

  actions :show, :new, :create, :update, :edit, :destroy

  def create
    super do |format|
      format.js { render 'create' }
    end  
  end

  # creating class_enrollment from students/show
  def enroll_student
 		@class_group_enrollment = ClassGroupEnrollment.new(params[:class_group_enrollment])
 		# handle not saving course enrollment
 		if @class_group_enrollment.save!
 			respond_to do |format|
 				format.js { render 'enroll_student' }
 			end
 		end
  end
  
end
