require 'spec_helper'
require 'support/requests/notable_spec'

describe 'Admin Student Notes' do

  as_admin

  let(:student) { create(:student) }
  let(:note) { create(:note, notable: student) }

  before :all do
    set_resource "student-note"
  end

  context 'new' do
    before do
      visit gaku.edit_admin_student_path(student)
      click tab_link
      @data = student
    end

    it_behaves_like 'new note'
  end

  context "existing", :js => true do
    before do
      note
      visit gaku.edit_admin_student_path(student)
      click tab_link
      @data = student
    end

    it_behaves_like 'edit note'

    it_behaves_like 'delete note'
  end

end
