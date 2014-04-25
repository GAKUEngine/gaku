module Gaku
  class Disposal
    def self.students
      Student.deleted
    end

    def self.teachers
      Teacher.deleted
    end

    def self.guardians
      Guardian.deleted
    end

    def self.exams
      Exam.deleted
    end

    def self.course_groups
      CourseGroup.deleted
    end

    def self.attachments
      Attachment.includes(:attachable).deleted
    end

    def self.student_addresses
      Address.includes(:addressable, :country).deleted.students
    end

    def self.teacher_addresses
      Address.includes(:addressable, :country).deleted.teachers
    end

    def self.student_contacts
      Contact.includes(:contactable, :contact_type).deleted.students
    end

    def self.teacher_contacts
      Contact.includes(:contactable, :contact_type).deleted.teachers
    end
  end
end
