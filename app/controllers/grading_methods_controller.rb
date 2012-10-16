class GradingMethodsController < ApplicationController

  def index
    @grading_methods = GradingMethod.all
  end

  def show
    @grading_method = GradingMethod.find(params[:id])
  end

  def new
    @grading_method = GradingMethod.new
  end

  def create
    @grading_method = GradingMethod.new(params[:grading_method])
    if @grading_method.save
      redirect_to grading_methods_path, notice: "Successfully created grading_method"
    else
      render :new
    end
  end

  def edit
    @grading_method = GradingMethod.find(params[:id])
  end

  def update
    @grading_method = GradingMethod.find(params[:id])
    if @grading_method.update_attributes(params[:grading_method])
      redirect_to @grading_method, notice: "Successfully updated grading_method"
    else
      render :edit
    end
  end

  def destroy
    @grading_method = GradingMethod.find(params[:id])
    @grading_method.destroy
    redirect_to grading_methods_url, notice: "Successfully destroyed grading_method"
  end

end
