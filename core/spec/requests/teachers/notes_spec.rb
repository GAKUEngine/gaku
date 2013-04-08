require 'spec_helper'
require 'support/requests/notable_spec'

describe 'Teacher Notes' do

  as_admin

  let(:teacher) { create(:teacher) }
  let(:teacher_with_note) { create(:teacher, :with_note) }
  let(:note) { create(:note) }

  before :all do
    set_resource "teacher-note"
  end

  context 'new' do

    before do
      @data = teacher
      visit gaku.teacher_path(@data)
    end

    it_behaves_like 'new note'
  end

  context "existing" do

    before do
      @data = teacher_with_note
      visit gaku.teacher_path(@data)
    end

    it_behaves_like 'edit note'

    it_behaves_like 'delete note'
  end

end
