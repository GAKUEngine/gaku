require 'spec_helper'
require 'support/requests/notable_spec'

describe 'Syllabus Notes' do

  as_admin

  let(:syllabus) { create(:syllabus) }
  let(:note) { create(:note, :notable => syllabus) }

  before :all do
    set_resource "syllabus-note"
  end

  context 'new', :js => true do
    before do
      visit gaku.syllabus_path(syllabus)
      @data = syllabus
    end

    it_behaves_like 'new note'
  end

  context "existing", :js => true do
    before do
      note
      visit gaku.syllabus_path(syllabus)
      @data = syllabus
    end

    it_behaves_like 'edit note'

    it_behaves_like 'delete note'
  end

end
