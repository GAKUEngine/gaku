require 'spec_helper'

describe 'Admin Student Enrollment Status' do

  as_admin

  let!(:enrollment_status_applicant) { create(:enrollment_status_applicant) }
  let!(:enrollment_status_admitted) { create(:enrollment_status_admitted) }
  let(:student) { create(:student, name: 'John', surname: 'Doe') }
  

  before :all do
    set_resource "student-enrollment-status"
    @submit_btn = '#submit-student-button'
    @cancel_btn = '#cancel-student-link'
  end

  context "existing" do
    before do
      student
      visit gaku.edit_admin_student_path(student)
    end

    context "enrollment status", js: true do
      context " #add" do
        before do
          click edit_link
          wait_until_visible modal
        end

        it ' adds' do
          select "#{enrollment_status_applicant.name}", from: 'student_enrollment_status_id'
          click @submit_btn
          page.should have_content "#{enrollment_status_applicant.name}"
        end

        it 'cancels adding' do
          click @cancel_btn
          wait_until_invisible modal
        end

      end

      context ' #edit', js: true do

        before do
          student.enrollment_status_id = enrollment_status_applicant.id
          student.save
          visit gaku.edit_admin_student_path(student)
          page.should have_content "#{enrollment_status_applicant.name}"
          click edit_link
          wait_for_ajax
        end

        it ' edits' do
          select "#{enrollment_status_admitted.name}", from: 'student_enrollment_status_id'
          click @submit_btn
          page.should have_content "#{enrollment_status_admitted.name}"
        end

        it 'cancels editing' do
          click @cancel_btn
          wait_until_invisible modal
          page.should have_content "#{enrollment_status_applicant.name}"
        end

      end

    end
  end
end
