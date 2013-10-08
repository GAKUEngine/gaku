require 'spec_helper'

describe 'Teacher Notes' do

  before { as :admin }

  let(:teacher) { create(:teacher) }
  let(:teacher_with_note) { create(:teacher, :with_note) }
  let(:note) { create(:note) }

  before :all do
    set_resource 'teacher-note'
  end

  context 'new', type: 'note'  do

    before do
      @data = teacher
      visit gaku.edit_teacher_path(@data)
      click tab_link
    end

    it_behaves_like 'new note'
  end

  context 'existing', type: 'note'  do

    before do
      @data = teacher_with_note
      visit gaku.edit_teacher_path(@data)
      click tab_link
    end

    it_behaves_like 'edit note'

    it_behaves_like 'delete note'
  end

end
