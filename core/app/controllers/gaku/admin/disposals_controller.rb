module Gaku
  class Admin::DisposalsController < Admin::BaseController

    authorize_resource class: false

    def index

    end

    def students
      @students = Disposal.students.page(params[:page])
    end

    def teachers
      @teachers = Disposal.teachers.page(params[:page])
    end

    def guardians
      @guardians = Disposal.guardians.page(params[:page])
    end

    def exams
      @exams = Disposal.exams.page(params[:page])
    end

    def course_groups
      @course_groups = Disposal.course_groups.page(params[:page])
    end

    def attachments
      @attachments = Disposal.attachments.page(params[:page])

    end

    def addresses
      @student_addresses = Disposal.student_addresses.page(params[:page])
      @teacher_addresses = Disposal.teacher_addresses.page(params[:page])
      set_student_and_teacher_count('Gaku::Address')
    end

    def contacts
      @student_contacts = Disposal.student_contacts.page(params[:page])
      @teacher_contacts = Disposal.teacher_contacts.page(params[:page])
      set_student_and_teacher_count('Gaku::Contact')
    end

    private

    def set_student_and_teacher_count(klass)
      @students_count = klass.constantize.deleted.students.count
      @teachers_count = klass.constantize.deleted.teachers.count
    end

  end
end
