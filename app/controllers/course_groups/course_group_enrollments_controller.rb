class CourseGroups::CourseGroupEnrollmentsController < ApplicationController
	
	inherit_resources
	actions :index, :show, :new, :create, :update, :edit, :destroy

	respond_to :js, :html

	before_filter :load_course_group, :only => [:new, :create, :destroy]


	def create
		@course_group = CourseGroup.find(params[:course_group_id])
		@course_group_enrollment = @course_group.course_group_enrollments.build(params[:course_group_enrollment])
		if @course_group_enrollment.save
			respond_to do |format|
				flash.now[:notice] = t('course_groups.course_added')
				format.js { render 'create' }
			end
		else
			respond_to do |format|
				format.js { render 'error' }
			end
		end
	end

	private 
		def load_course_group
      @course_group = CourseGroup.find(params[:course_group_id])
    end
end
