require 'spec_helper'
require 'support/requests/notable_spec'

describe 'ClassGroup Notes' do

  as_admin

  let(:class_group) { create(:class_group) }
  let(:note) { create(:note, :notable => class_group) }

  before :all do
    set_resource "class-group-note"
  end

  before do
    class_group
    visit gaku.class_group_path(class_group)
    @data = class_group
  end

  it_behaves_like 'new note'

  context "existing", :js => true do
    before do
      note
      visit gaku.class_group_path(class_group)
      @data = class_group
    end

    it_behaves_like 'edit note'

    it_behaves_like 'delete note'

  end
    
end