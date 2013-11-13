require 'spec_helper'

describe 'Student Commute Method Type' do

  before(:all) { set_resource 'student' }
  before { as :admin }

  let(:student) { create(:student) }
  let!(:commute_method_type) { create(:commute_method_type) }

  it 'create and show', js: true do
    visit gaku.edit_student_path(student)
    select commute_method_type.name, from: 'student_commute_method_type_id'
    click submit

    flash_updated?
    within('#student_commute_method_type_id') { has_content? commute_method_type.name }
    student.reload
    expect(student.commute_method_type.name).to eq commute_method_type.name
  end

end
