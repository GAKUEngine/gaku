class Students::CourseEnrollmentsController < ApplicationController

  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy

  before_filter :load_student, :only => [ :new, :create, :edit, :update ]

  def new
    @course_enrollment = CourseEnrollment.new
    render 'new'  
  end

  def create
    super do |format|
      if @student.course_enrollments << @course_enrollment
        format.js { render 'create' }  
      else
        @errors = @course_enrollment.errors
        format.js { render 'error' }
      end
    end  
  end

  def edit
    super do |format|
      format.js {render 'edit'}  
    end  
  end

  def update
    super do |format|
      format.js { render 'update' }  
    end  
  end

  def destroy
    super do |format|
      format.js { render :nothing => true }
    end
  end 

  def make_primary
    @contact = Contact.find(params[:id])
    if params[:guardian_id]
      #handle guardian contact make primary
    else
      #handle student contact make primary
      @contact.make_primary_student
      respond_with(@contact) do |format|
        format.js {render 'student_make_primary'}
      end
    end
  end

  private 
    def load_student
      @student = Student.find(params[:student_id])
    end
end
