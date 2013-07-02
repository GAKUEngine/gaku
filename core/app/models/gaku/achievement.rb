module Gaku
  class Achievement < ActiveRecord::Base
    has_many :student_achievements
    has_many :students, through: :student_achievements

    belongs_to :external_school_record

    has_attached_file :badge

    validates :name, presence: true

    def to_s
      name
    end

  end
end
