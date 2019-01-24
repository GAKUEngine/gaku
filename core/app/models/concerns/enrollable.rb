module Enrollable
  extend ActiveSupport::Concern

  included do
    has_many :enrollments, as: :enrollable, dependent: :destroy
    has_many :students, through: :enrollments
  end
end
