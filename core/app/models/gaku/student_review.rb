module Gaku
  class StudentReview < ActiveRecord::Base
    belongs_to :student, required: false
    belongs_to :student_review_category, required: false
    belongs_to :student_reviewable, polymorphic: true, required: false

    validates :content, :student_id, :student_review_category_id, :student_reviewable_id, :student_reviewable_type , presence: true
    validates :student_id, uniqueness: { scope: [:student_reviewable_type, :student_reviewable_id] }

  end
end
