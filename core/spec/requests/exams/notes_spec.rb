require 'spec_helper'
require 'support/requests/notable_spec'

describe 'Exam Notes' do

  as_admin

  let(:exam) { create(:exam) }
  let(:note) { create(:note, :notable => exam) }

  before :all do
    set_resource "exam-note"
  end

  context 'new', :js => true do
    before do
      visit gaku.exam_path(exam)
      @data = exam
    end

    it_behaves_like 'new note'
  end

  context "existing", :js => true do
    before do
      note
      visit gaku.exam_path(exam)
      @data = exam
    end

    it_behaves_like 'edit note'

    it_behaves_like 'delete note'
  end

end
