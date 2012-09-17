class CourseGroupsController < ApplicationController
	inherit_resources

	before_filter :load_before_show, :only => [:show]

	def create
		super do |format|
			@course_groups = CourseGroup.all
			flash.now[:notice] = t('course_groups.course_group_created')
			format.js { render 'create'}
		end
	end

	def edit
		super do |format|
			format.js { render 'edit' }
		end
	end

	def update
		super do |format|
			@course_groups = CourseGroup.all
			format.js { render 'update'}
		end
	
	end

	def destroy
		super do |format|
    format.js { render :nothing => true }
  end
  end

	private

	def load_before_show
		@course_group_enrollment = CourseGroupEnrollment.first
	end

	end
