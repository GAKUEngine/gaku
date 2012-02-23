class ClassGroupEnrollmentsController < ApplicationController
  # GET /class_group_enrollments
  # GET /class_group_enrollments.json
  def index
    @class_group_enrollments = ClassGroupEnrollment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @class_group_enrollments }
    end
  end

  # GET /class_group_enrollments/1
  # GET /class_group_enrollments/1.json
  def show
    @class_group_enrollment = ClassGroupEnrollment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @class_group_enrollment }
    end
  end

  # GET /class_group_enrollments/new
  # GET /class_group_enrollments/new.json
  def new
    @class_group_enrollment = ClassGroupEnrollment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @class_group_enrollment }
    end
  end

  # GET /class_group_enrollments/1/edit
  def edit
    @class_group_enrollment = ClassGroupEnrollment.find(params[:id])
  end

  # POST /class_group_enrollments
  # POST /class_group_enrollments.json
  def create
    @class_group_enrollment = ClassGroupEnrollment.new(params[:class_group_enrollment])

    respond_to do |format|
      if @class_group_enrollment.save
        format.html { redirect_to @class_group_enrollment, notice: 'Class group enrollment was successfully created.' }
        format.json { render json: @class_group_enrollment, status: :created, location: @class_group_enrollment }
      else
        format.html { render action: "new" }
        format.json { render json: @class_group_enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /class_group_enrollments/1
  # PUT /class_group_enrollments/1.json
  def update
    @class_group_enrollment = ClassGroupEnrollment.find(params[:id])

    respond_to do |format|
      if @class_group_enrollment.update_attributes(params[:class_group_enrollment])
        format.html { redirect_to @class_group_enrollment, notice: 'Class group enrollment was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @class_group_enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /class_group_enrollments/1
  # DELETE /class_group_enrollments/1.json
  def destroy
    @class_group_enrollment = ClassGroupEnrollment.find(params[:id])
    @class_group_enrollment.destroy

    respond_to do |format|
      format.html { redirect_to class_group_enrollments_url }
      format.json { head :ok }
    end
  end
end
