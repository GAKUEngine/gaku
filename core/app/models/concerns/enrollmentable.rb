module Enrollmentable
  extend ActiveSupport::Concern

  included do
    has_many :enrollments, as: :enrollmentable, dependent: :destroy
    has_many :students, through: :enrollments
  end

end
