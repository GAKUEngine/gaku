module Gaku
  class EnrollmentStatus < ActiveRecord::Base

    has_many :students, foreign_key: :enrollment_status_code, primary_key: :code

    translates :name

    attr_accessible :code, :name, :is_active, :immutable

    validates :code, presence: true

    before_create :set_name

    scope :active,  -> { where(is_active: true) }

    def set_name
      self.name = code if name.nil?
    end

    def to_s
      name
    end

  end
end
