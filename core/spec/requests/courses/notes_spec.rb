require 'spec_helper'
require 'support/requests/notable_spec'

describe 'Course Notes' do

  as_admin

  let(:course) { create(:course) }
  let(:note) { create(:note, :notable => course) }

  before :all do
    set_resource "course-note"
  end

  context 'new', :js => true do
    before do
      visit gaku.course_path(course)
      @data = course
    end

    it_behaves_like 'new note'
  end

  context "existing", :js => true do
    before do
      note
      visit gaku.course_path(course)
      @data = course
    end

    it_behaves_like 'edit note'

    it_behaves_like 'delete note'
  end

end
