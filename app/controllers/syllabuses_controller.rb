class SyllabusesController < ApplicationController
  # GET /syllabuses
  # GET /syllabuses.json
  def index
    @syllabuses = Syllabus.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @syllabuses }
    end
  end

  # GET /syllabuses/1
  # GET /syllabuses/1.json
  def show
    @syllabus = Syllabus.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @syllabus }
    end
  end

  # GET /syllabuses/new
  # GET /syllabuses/new.json
  def new
    @syllabus = Syllabus.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @syllabus }
    end
  end

  # GET /syllabuses/1/edit
  def edit
    @syllabus = Syllabus.find(params[:id])
  end

  # POST /syllabuses
  # POST /syllabuses.json
  def create
    @syllabus = Syllabus.new(params[:syllabus])

    respond_to do |format|
      if @syllabus.save
        format.html { redirect_to @syllabus, notice: 'Syllabus was successfully created.' }
        format.json { render json: @syllabus, status: :created, location: @syllabus }
      else
        format.html { render action: "new" }
        format.json { render json: @syllabus.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /syllabuses/1
  # PUT /syllabuses/1.json
  def update
    @syllabus = Syllabus.find(params[:id])

    respond_to do |format|
      if @syllabus.update_attributes(params[:syllabus])
        format.html { redirect_to @syllabus, notice: 'Syllabus was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @syllabus.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /syllabuses/1
  # DELETE /syllabuses/1.json
  def destroy
    @syllabus = Syllabus.find(params[:id])
    @syllabus.destroy

    respond_to do |format|
      format.html { redirect_to syllabuses_url }
      format.json { head :ok }
    end
  end
end
