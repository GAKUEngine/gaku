class CourseEnrollmentsController < ApplicationController
  # GET /course_enrollments
  # GET /course_enrollments.json
  def index
    @course_enrollments = CourseEnrollment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @course_enrollments }
    end
  end

  # GET /course_enrollments/1
  # GET /course_enrollments/1.json
  def show
    @course_enrollment = CourseEnrollment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course_enrollment }
    end
  end

  # GET /course_enrollments/new
  # GET /course_enrollments/new.json
  def new
    @course_enrollment = CourseEnrollment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course_enrollment }
    end
  end

  # GET /course_enrollments/1/edit
  def edit
    @course_enrollment = CourseEnrollment.find(params[:id])
  end

  # POST /course_enrollments
  # POST /course_enrollments.json
  def create
    @course_enrollment = CourseEnrollment.new(params[:course_enrollment])

    respond_to do |format|
      if @course_enrollment.save
        format.html { redirect_to @course_enrollment, notice: 'Course enrollment was successfully created.' }
        format.json { render json: @course_enrollment, status: :created, location: @course_enrollment }
      else
        format.html { render action: "new" }
        format.json { render json: @course_enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /course_enrollments/1
  # PUT /course_enrollments/1.json
  def update
    @course_enrollment = CourseEnrollment.find(params[:id])

    respond_to do |format|
      if @course_enrollment.update_attributes(params[:course_enrollment])
        format.html { redirect_to @course_enrollment, notice: 'Course enrollment was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @course_enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_enrollments/1
  # DELETE /course_enrollments/1.json
  def destroy
    @course_enrollment = CourseEnrollment.find(params[:id])
    @course_enrollment.destroy

    respond_to do |format|
      format.html { redirect_to course_enrollments_url }
      format.json { head :ok }
    end
  end
end
