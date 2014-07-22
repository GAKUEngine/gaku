module Gaku
  class Admin::StudentReviewCategoriesController < Admin::BaseController

    respond_to :js

    before_action :set_student_review_category, only: %i( edit update destroy )

    def index
      @student_review_categories = StudentReviewCategory.all
      set_count
      respond_with @student_review_categories
    end

    def new
      @student_review_category = StudentReviewCategory.new
      respond_with @student_review_category
    end

    def create
      @student_review_category = StudentReviewCategory.create(student_review_category_params)
      set_count
      respond_with @student_review_category
    end

    def edit
    end

    def update
      @student_review_category.update(student_review_category_params)
      respond_with @student_review_category
    end

    def destroy
      @student_review_category.destroy!
      set_count
      respond_with @student_review_category
    end

    private

    def student_review_category_params
      params.require(:student_review_category).permit(student_review_category_attrs)
    end

    def student_review_category_attrs
      %i( name )
    end

    def set_student_review_category
      @student_review_category = StudentReviewCategory.find(params[:id])
    end

    def set_count
      @count = StudentReviewCategory.count
    end
  end
end
