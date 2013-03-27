require 'spec_helper'
require 'support/requests/notable_spec'

describe 'Syllabus Notes' do

  as_admin

  let(:syllabus) { create(:syllabus) }
  let(:syllabus_with_note) { create(:syllabus, :with_note) }
  let(:note) { create(:note) }

  before :all do
    set_resource "syllabus-note"
  end

  context 'new', :js => true do
    before do
      @data = syllabus
      visit gaku.syllabus_path(@data)
    end

    it_behaves_like 'new note'
  end

  context "existing", :js => true do
    before do
      @data = syllabus_with_note
      visit gaku.syllabus_path(@data)
    end

    it_behaves_like 'edit note'

    it_behaves_like 'delete note'
  end

end
