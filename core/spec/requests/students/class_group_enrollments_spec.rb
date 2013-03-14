require 'spec_helper'

describe 'Student Class Group Enrollments' do

  as_admin

  let(:student) { create(:student, name: 'John', surname: 'Doe') }
  let(:class_group) { create(:class_group, name:'Biology') }
  let!(:el) { '#class-group' }

  before :all do
    set_resource "student"
  end


  it 'enrolls to class', js: true do
    student
    class_group
    visit gaku.edit_student_path(student)

    expect do
      click el
      wait_until_visible modal

      select 'Biology', from: 'class_group_enrollment_class_group_id'
      fill_in 'class_group_enrollment_seat_number', with: '77'
      click_on "Create Class Enrollment"
      click_on 'Cancel'
      wait_until_invisible modal
    end.to change(Gaku::ClassGroupEnrollment, :count).by 1

    click el
    wait_until_visible '#new-class-group-enrollment-modal'
    within('#new-class-group-enrollment-modal') do
      page.should have_content 'Biology'
      page.should have_content '77'
    end

    visit gaku.edit_student_path(student)
    within(el) do
      page.should have_content 'Biology'
      page.should have_content student.class_groups.last.grade.try(:to_s)
    end
  end


end
