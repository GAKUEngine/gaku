module Gaku
	class CourseGroups::CourseGroupEnrollmentsController < GakuController

		load_and_authorize_resource :course_group_enrollment, :class => Gaku::CourseGroupEnrollment

		inherit_resources
		actions :index, :show, :new, :create, :update, :edit, :destroy
		respond_to :js, :html

		before_filter :course_group, :only => [:new, :create, :destroy]
		before_filter :count, :only => [:create, :destroy]

		def create
			@course_group_enrollment = @course_group.course_group_enrollments.build(params[:course_group_enrollment])
			if @course_group_enrollment.save
				respond_to do |format|
					flash.now[:notice] = t('notice.added', :resource => t('course.singular'))
					format.js { render 'create' }
				end
			else
				respond_to do |format|
					format.js { render 'error' }
				end
			end
		end

		private
			def course_group
	      @course_group = CourseGroup.find(params[:course_group_id])
	    end

	    def count
	    	course_group
	    	@count = @course_group.courses.count
	    end
	end
end
