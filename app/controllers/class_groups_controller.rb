class ClassGroupsController < ApplicationController
  # GET /class_groups
  # GET /class_groups.json
  def index
    @class_groups = ClassGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @class_groups }
    end
  end

  # GET /class_groups/1
  # GET /class_groups/1.json
  def show
    @class_group = ClassGroup.find(params[:id])
    @class_group_enrollments = ClassGroupEnrollment.where(:class_group_id => @class_group)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @class_group }
    end
  end

  # GET /class_groups/new
  # GET /class_groups/new.json
  def new
    @class_group = ClassGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @class_group }
    end
  end

  # GET /class_groups/1/edit
  def edit
    @class_group = ClassGroup.find(params[:id])
  end

  # POST /class_groups
  # POST /class_groups.json
  def create
    @class_group = ClassGroup.new(params[:class_group])

    respond_to do |format|
      if @class_group.save
        format.html { redirect_to @class_group, notice: 'Class group was successfully created.' }
        format.json { render json: @class_group, status: :created, location: @class_group }
      else
        format.html { render action: "new" }
        format.json { render json: @class_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /class_groups/1
  # PUT /class_groups/1.json
  def update
    @class_group = ClassGroup.find(params[:id])

    respond_to do |format|
      if @class_group.update_attributes(params[:class_group])
        format.html { redirect_to @class_group, notice: 'Class group was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @class_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /class_groups/1
  # DELETE /class_groups/1.json
  def destroy
    @class_group = ClassGroup.find(params[:id])
    @class_group.destroy

    respond_to do |format|
      format.html { redirect_to class_groups_url }
      format.json { head :ok }
    end
  end
end
