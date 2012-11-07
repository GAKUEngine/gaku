module Gaku
	class Syllabuses::AssignmentsController < GakuController

	  def create
	    if @syllabus.update_attributes(params[:syllabus])
	      respond_to do |format|
	        format.js { render 'create' }  
	      end
	    end  
	  end
	  
	end
end