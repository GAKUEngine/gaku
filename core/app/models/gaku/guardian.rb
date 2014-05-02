module Gaku
  class Guardian < ActiveRecord::Base
    include Person, Addresses, Contacts, Picture

    belongs_to :user
    has_many :student_guardians, dependent: :destroy
    has_many :students, through: :student_guardians

    after_create :reset_student_count
    after_destroy :reset_student_count

    private

    def reset_student_count
      students.each do |s|
        Student.reset_counters(s.id, :guardians)
      end
    end
  end
end
