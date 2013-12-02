require 'spec_helper'

describe 'Admin Student Disposals' do

  before { as :admin }

  let(:deleted_student) { create(:student, deleted: true) }
  let(:student) { create(:student, deleted: false) }

  before do
    student
    deleted_student
    visit gaku.admin_disposals_path
    click '#students-tab-link'
  end

  xit 'indexes deleted students', js: true do
    has_content? deleted_student.name
    has_content? deleted_student.surname

    has_no_content? student.name
    has_no_content? student.surname
  end

  xit 'shows deleted student', js: true do
    click show_link
    page.has_content? 'Student information'
    expect(current_path).to eq "/students/#{deleted_student.id}/show_deleted"
  end

  xit 'recovers deleted student', js: true do
    expect do
      click recovery_link
      flash_recovered?
      deleted_student.reload
    end.to change(deleted_student, :deleted)

    has_no_content? deleted_student.name
    has_no_content? deleted_student.surname
  end

  xit 'deletes student permanently', js: true do
    click delete_link
    accept_alert
    flash_destroyed?

    has_no_content? deleted_student.name
    has_no_content? deleted_student.surname
  end

end
