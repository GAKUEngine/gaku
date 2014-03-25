require 'spec_helper'

describe 'Student Notes' do

  before { as :admin }
  before(:all) { set_resource 'student-note' }

  let(:student) { create(:student) }
  let(:student_with_note) { create(:student, :with_note) }
  let(:note) { create(:note, notable: student) }

  context 'new', type: 'note'  do
    before do
      @resource = student
      visit gaku.edit_student_path(@resource)
      click tab_link
    end

    it_behaves_like 'new note'
  end

  context 'existing', js: true, type: 'note'  do
    before do
      @resource = student_with_note
      visit gaku.edit_student_path(@resource)
      click tab_link
    end

    it_behaves_like 'edit note'
    it_behaves_like 'delete note'
  end

end
