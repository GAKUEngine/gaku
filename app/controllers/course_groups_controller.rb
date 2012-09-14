class CourseGroupsController < ApplicationController
	inherit_resources

	before_filter :load_before_show, :only => [:show]

	private

	def load_before_show
		@course_group_enrollment = CourseGroupEnrollment.first
	end

	end
