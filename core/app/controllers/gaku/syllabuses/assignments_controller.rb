module Gaku
	class Syllabuses::AssignmentsController < GakuController

    before_filter :count, :only => :create
	  def create
	    if @syllabus.update_attributes(params[:syllabus])
	      respond_to do |format|
	        format.js { render 'create' }
	      end
	    end
	  end

	  private

	  def count
      @count = Syllabus.assignments.count
	  end

	end
end
