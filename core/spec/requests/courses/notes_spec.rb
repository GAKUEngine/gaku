require 'spec_helper'

describe 'Course Notes' do

  before { as :admin }
  before(:all) { set_resource 'course-note' }

  let(:course) { create(:course) }
  let(:course_with_note) { create(:course, :with_note) }

  context 'new', js: true, type: 'note'  do
    before do
      @resource = course
      visit gaku.course_path(@resource)
    end

    it_behaves_like 'new note'
  end

  context 'existing', js: true, type: 'note'  do
    before do
      @resource = course_with_note
      visit gaku.course_path(@resource)
    end

    it_behaves_like 'edit note'
    it_behaves_like 'delete note'
  end

end
