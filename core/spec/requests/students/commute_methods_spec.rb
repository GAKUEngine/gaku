require 'spec_helper'

describe 'Student Commute Methods' do

  as_admin

  let(:student) { create(:student, name: 'John', surname: 'Doe') }
  let(:commute_method_type) { create(:commute_method_type) }
  let(:commute_method_type_train) { create(:commute_method_type, name: 'Train') }
  let(:commute_method) { create(:commute_method, commute_method_type: commute_method_type_train, student: student) }

  before :all do
    set_resource "student-commute-method"
    submit = 'submit-student-commute-method-button'
    edit_link = '#edit-student-commute-method-link'
  end

  context "existing" do
    before do
      student
      visit gaku.students_path
    end

    context "commute method", js: true do
      context " #add" do
        before do
          commute_method_type
          visit gaku.edit_student_path(student)
          click '#edit-student-commute-method-link'
          wait_until_visible modal
        end

        it ' adds' do
          select "#{commute_method_type.name}", from: 'commute_method_commute_method_type_id'
          click '#submit-student-commute-method-button'
          page.should have_content "#{commute_method_type}"
        end

        it 'cancels adding' do
          click '#cancel-student-commute-method-link'
          wait_until_invisible modal
        end
      end

      context ' #edit' do
        before do
          commute_method_type.commute_methods<<commute_method
          commute_method_type_train
          visit gaku.edit_student_path(student)
          page.should have_content "#{student.commute_method.commute_method_type}"
          click '#edit-student-commute-method-link'
        end

        it ' edits' do
          select 'Train', from: 'commute_method_commute_method_type_id'
          click '#submit-student-commute-method-button'
          wait_until_visible '#edit-student-commute-method-link'
          page.should have_content "Train"
        end

        it 'cancels editing' do
          click '#cancel-student-commute-method-link'
          wait_until_invisible modal
          page.should have_content "#{commute_method_type}"
        end

      end

    end
  end
end
