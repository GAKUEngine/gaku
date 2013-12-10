require 'spec_helper'

describe 'Student Enrollment Status' do

  before(:all) { set_resource 'student' }
  before { as :admin }

  let(:student) { create(:student) }
  let!(:enrollment_status) { create(:enrollment_status, name: 'Enrolled', code: 'enrolled') }

  it 'create and show', js: true do
    visit gaku.edit_student_path(student)
    select enrollment_status.name, from: 'student_enrollment_status_code'
    click submit

    flash_updated?
    within('#student_enrollment_status_code') { has_content? enrollment_status.name }
    student.reload
    expect(student.enrollment_status_code).to eq enrollment_status.code
  end

end
