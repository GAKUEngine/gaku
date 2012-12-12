module Gaku
	class Students::CommuteMethodsController < GakuController

		inherit_resources
		respond_to :html, :js

		before_filter :student

		#def new
		#	super do |format|
		#		format.js { render }
		#	end
		#end

		def create
			@commute_method = CommuteMethod.create!(params[:commute_method])
			@student.update_attribute('commute_method_id', @commute_method.id)
			respond_to do |format|
				flash.now[:notice] = t(:'commute_methods.created')
				format.js { render }
			end
		end

		#def edit
	 	#	super do |format|
		#		format.js {render}
		#	end
		#end

		#def update
		#	flash.now[:notice] = t('commute_methods.updated')
		#	super do |format|
		#		format.js {render}
		#	end
		#end

		private

		def student
			@student = Student.find(params[:student_id])
		end

	end
end
