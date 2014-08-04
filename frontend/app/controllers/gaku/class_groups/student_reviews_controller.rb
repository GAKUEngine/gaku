module Gaku
  class ClassGroups::StudentReviewsController < GakuController

    respond_to :js

    before_action :set_class_group, only: %i( index create edit )
    before_action :set_student, only: %i( index edit )
    before_action :set_student_review, only: %i( edit update destroy )
    before_action :load_data, only: %i( index edit )
    def index
      @student_reviews = @class_group.student_reviews.where(student_id: params[:student_id])
      respond_with @student_reviews
    end

    def create
      @student_review = @class_group.student_reviews.create!(student_review_params)
      respond_with @student_review
    end

    def edit
    end

    def update
      @student_review.update(student_review_params)
      respond_with @student_review
    end

    def destroy
      @student_review.destroy!
      respond_with @student_review
    end

    private

    def student_review_params
      params.require(:student_review).permit(student_review_attr)
    end

    def student_review_attr
      %i( student_id content student_review_category_id )
    end

    def set_class_group
      @class_group = ClassGroup.find(params[:class_group_id])
    end

    def set_student
      @student = Student.find(params[:student_id])
    end

    def set_student_review
      @student_review = StudentReview.find(params[:id])
    end

    def load_data
      @student_review_categories = StudentReviewCategory.all
    end

  end
end
