class CourseGroups::CourseGroupEnrollmentsController < ApplicationController
	inherit_resources

	before_filter :load_course_group, :only => [:create, :destroy]


	def create
		@course_group_enrollment = @course_group.course_group_enrollments.build(params[:course_group_enrollment])
		if @course_group_enrollment.save
			respond_to do |format|
				flash.now[:notice] = t('course_groups.course_added')
				format.js { render '/course_groups/course_group_enrollments/create' }
			end
		else
			respond_to do |format|
				format.js { render '/course_groups/course_group_enrollments/error' }
			end
		end
	end

	def destroy
		super do |format|
			format.js { render '/course_groups/course_group_enrollments/destroy'}
		end
	end

	private
	def load_course_group
		@course_group = CourseGroup.find(params[:course_group_id])
	end

end
