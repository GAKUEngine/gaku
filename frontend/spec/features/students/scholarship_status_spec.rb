require 'spec_helper'

describe 'Student Scholarship Status' do

  before(:all) { set_resource 'student' }
  before { as :admin }

  let(:student) { create(:student) }
  let!(:scholarship_status) { create(:scholarship_status) }

  it 'create and show', js: true do
    visit gaku.edit_student_path(student)
    select scholarship_status.name, from: 'student_scholarship_status_id'
    click submit

    flash_updated?
    within('#student_scholarship_status_id') { has_content? scholarship_status.name }
    student.reload
    expect(student.scholarship_status.name).to eq scholarship_status.name
  end

end
