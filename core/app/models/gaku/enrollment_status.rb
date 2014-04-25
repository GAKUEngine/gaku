module Gaku
  class EnrollmentStatus < ActiveRecord::Base
    has_many :students, foreign_key: :enrollment_status_code, primary_key: :code

    translates :name

    validates :code, presence: true, uniqueness: true

    before_create :set_name

    scope :active,  -> { where(active: true) }

    def to_s
      name
    end

    private

    def set_name
      self.name = code if name.nil?
    end
  end
end
