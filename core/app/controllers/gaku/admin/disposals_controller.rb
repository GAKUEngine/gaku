module Gaku
  class Admin::DisposalsController < Admin::BaseController

    authorize_resource class: false

    def index

    end

    def students
      @students = Student.deleted
                         .page(params[:page])
                         .per(Preset.default_per_page)
    end

    def teachers
      @teachers = Teacher.deleted
                         .page(params[:page])
                         .per(Preset.default_per_page)
    end

    def guardians
      @guardians = Guardian.deleted
                           .page(params[:page])
                           .per(Preset.default_per_page)
    end

    def exams
      @exams = Exam.deleted
                   .page(params[:page])
                   .per(Preset.default_per_page)
    end

    def course_groups
      @course_groups = CourseGroup.deleted
                                  .page(params[:page])
                                  .per(Preset.default_per_page)
    end

    def attachments
      @attachments = Attachment.includes(:attachable)
                               .deleted
                               .page(params[:page])
                               .per(Preset.default_per_page)
    end

    def addresses
      @student_addresses = Address.includes(:addressable, :country)
                                  .deleted
                                  .students
                                  .page(params[:page])
                                  .per(Preset.default_per_page)

      @teacher_addresses = Address.includes(:addressable, :country)
                                  .deleted
                                  .teachers
                                  .page(params[:page])
                                  .per(Preset.default_per_page)

      set_student_and_teacher_count('Gaku::Address')
    end

    def contacts
      @student_contacts = Contact.includes(:contactable, :contact_type)
                                 .deleted
                                 .students
                                 .page(params[:page])
                                 .per(Preset.default_per_page)

      @teacher_contacts = Contact.includes(:contactable, :contact_type)
                                 .deleted
                                 .teachers
                                 .page(params[:page])
                                 .per(Preset.default_per_page)

      set_student_and_teacher_count('Gaku::Contact')
    end

    private

    def set_student_and_teacher_count(klass)
      @students_count = klass.constantize.deleted.students.count
      @teachers_count = klass.constantize.deleted.teachers.count
    end

  end
end
