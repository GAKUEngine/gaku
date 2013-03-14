require 'spec_helper'
require 'support/requests/notable_spec'

describe 'Teacher Notes' do

  as_admin

  let(:teacher) { create(:teacher) }
  let(:note) { create(:note, notable: teacher) }

  before :all do
    set_resource "teacher-note"
  end

  context 'new' do
    before do
      visit gaku.teacher_path(teacher)
      @data = teacher
    end

    it_behaves_like 'new note'
  end

  context "existing" do
    before do
      note
      visit gaku.teacher_path(teacher)
      @data = teacher
    end

    it_behaves_like 'edit note'

    it_behaves_like 'delete note'
  end

end
