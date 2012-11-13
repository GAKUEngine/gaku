module Gaku
  class Students::EnrollmentStatuses::NotesController < GakuController

  	inherit_resources

  	respond_to :js, :html

  	before_filter :load_resources
    before_filter :load_notes, :only => [:index]

  	def create
      @enrollment_status = EnrollmentStatus.find(params[:enrollment_status_id])
      @note = @enrollment_status.notes.build(params[:note])
      @note.save
      
      load_notes
      @note = Note.new
      
      respond_with([@note,@notes]) do |format|
  			format.js { render 'create'}
  		end
  	end

  	def update
  		super do |format|
  			load_notes
  			@note = Note.new
  			format.js { render 'update'}
  		end
  	end

  	def destroy
  		super do |format|
  			format.js {render :nothing => true}
  		end
  	end

  	private


  	def load_notes
  		@notes = @enrollment_status.notes
  	end

  	def load_resources
  		@student = Student.find(params[:student_id])
  		@enrollment_status = EnrollmentStatus.find(params[:enrollment_status_id])
  	end
  end
end