require 'spec_helper'

describe 'Admin Teacher Disposals' do

  before { as :admin }

  let(:deleted_teacher) { create(:teacher, deleted: true) }
  let(:teacher) { create(:teacher, deleted: false) }

  before do
    teacher
    deleted_teacher
    visit gaku.admin_disposals_path
    click '#teachers-tab-link'
  end

  it 'indexes deleted teachers' do
    has_content? deleted_teacher.name
    has_content? deleted_teacher.surname

    has_no_content? teacher.name
    has_no_content? teacher.surname
  end

  it 'shows deleted teacher' do
    click show_link
    expect(current_path).to eq "/teachers/#{deleted_teacher.id}/show_deleted"
  end

  it 'recovers deleted teacher', js: true do
    expect do
      click recovery_link
      flash_recovered?
      deleted_teacher.reload
    end.to change(deleted_teacher, :deleted)

    has_no_content? deleted_teacher.name
    has_no_content? deleted_teacher.surname
  end

  it 'deletes teacher permanently', js: true do
    click delete_link
    accept_alert
    flash_destroyed?

    has_no_content? deleted_teacher.name
    has_no_content? deleted_teacher.surname
  end

end