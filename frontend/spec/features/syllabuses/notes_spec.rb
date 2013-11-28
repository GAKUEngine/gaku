require 'spec_helper'

describe 'Syllabus Notes' do

  before { as :admin }
  before(:all) { set_resource 'syllabus-note' }

  let(:syllabus) { create(:syllabus) }
  let(:syllabus_with_note) { create(:syllabus, :with_note) }

  context 'new', js: true do
    before do
      @resource = syllabus
      visit gaku.edit_syllabus_path(@resource)
      click tab_link
    end

    it_behaves_like 'new note'
  end

  context 'existing', js: true do
    before do
      @resource = syllabus_with_note
      visit gaku.edit_syllabus_path(@resource)
      click tab_link
    end

    it_behaves_like 'edit note'
    it_behaves_like 'delete note'
  end

end
