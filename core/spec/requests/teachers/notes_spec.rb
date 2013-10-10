require 'spec_helper'

describe 'Teacher Notes' do

  before { as :admin }
  before(:all) { set_resource 'teacher-note' }

  let(:teacher) { create(:teacher) }
  let(:teacher_with_note) { create(:teacher, :with_note) }
  let(:note) { create(:note) }

  context 'new', type: 'note'  do
    before do
      @resource = teacher
      visit gaku.edit_teacher_path(@resource)
      click tab_link
    end

    it_behaves_like 'new note'
  end

  context 'existing', type: 'note'  do

    before do
      @resource = teacher_with_note
      visit gaku.edit_teacher_path(@resource)
      click tab_link
    end

    it_behaves_like 'edit note'
    it_behaves_like 'delete note'
  end

end
