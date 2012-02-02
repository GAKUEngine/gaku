class StudentsController < ApplicationController
  # GET /admin/students
  # GET /admin/students.json
  def index
    @admin_students = Student.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_students }
    end
  end

  # GET /admin/students/1
  # GET /admin/students/1.json
  def show
    @admin_student = Admin::Student.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_student }
    end
  end

  # GET /admin/students/new
  # GET /admin/students/new.json
  def new
    @admin_student = Admin::Student.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_student }
    end
  end

  # GET /admin/students/1/edit
  def edit
    @admin_student = Admin::Student.find(params[:id])
  end

  # POST /admin/students
  # POST /admin/students.json
  def create
    @admin_student = Admin::Student.new(params[:admin_student])

    respond_to do |format|
      if @admin_student.save
        format.html { redirect_to @admin_student, notice: 'Student was successfully created.' }
        format.json { render json: @admin_student, status: :created, location: @admin_student }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/students/1
  # PUT /admin/students/1.json
  def update
    @admin_student = Admin::Student.find(params[:id])

    respond_to do |format|
      if @admin_student.update_attributes(params[:admin_student])
        format.html { redirect_to @admin_student, notice: 'Student was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/students/1
  # DELETE /admin/students/1.json
  def destroy
    @admin_student = Admin::Student.find(params[:id])
    @admin_student.destroy

    respond_to do |format|
      format.html { redirect_to admin_students_url }
      format.json { head :ok }
    end
  end
end

