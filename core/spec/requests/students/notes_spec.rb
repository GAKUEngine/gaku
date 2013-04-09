require 'spec_helper'
require 'support/requests/notable_spec'

describe 'Student Notes' do

  as_admin

  let(:student) { create(:student) }
  let(:student_with_note) { create(:student, :with_note) }
  let(:note) { create(:note, notable: student) }

  before :all do
    set_resource "student-note"
  end

  context 'new' do
    before do
      @data = student
      visit gaku.edit_student_path(@data)
      click tab_link
    end

    it_behaves_like 'new note'
  end

  context "existing", :js => true do
    before do
      @data = student_with_note
      visit gaku.edit_student_path(@data)
      click tab_link
    end

    it_behaves_like 'edit note'

    it_behaves_like 'delete note'
  end

end
