require 'spec_helper'

describe 'Exam Notes' do

  before { as :admin }
  before(:all) { set_resource 'exam-note' }

  let(:exam) { create(:exam) }
  let(:exam_with_note) { create(:exam, :with_note) }

  context 'new', js: true, type: 'note'  do
    before do
      @resource = exam
      visit gaku.exam_path(@resource)
    end

    it_behaves_like 'new note'
  end

  context 'existing', js: true, type: 'note'  do
    before do
      @resource = exam_with_note
      visit gaku.exam_path(@resource)
    end

    it_behaves_like 'edit note'
    it_behaves_like 'delete note'
  end

end
