module Gaku
  class Guardian < ActiveRecord::Base

    include Person, Addresses, Contacts, Picture

    belongs_to :user
    has_many :student_guardians, :dependent => :destroy
    has_many :students, :through => :student_guardians

    attr_accessible :relationship

    after_create :refresh_student_counts
    after_destroy :refresh_student_counts

    private

      def refresh_student_counts
        students.each do |s|
          Student.reset_counters(s.id ,:guardians)
        end
      end
  end
end
