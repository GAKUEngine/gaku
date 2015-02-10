module StudentReviewable
  extend ActiveSupport::Concern

  included do
    has_many :student_reviews, as: :student_reviewable
  end
end
