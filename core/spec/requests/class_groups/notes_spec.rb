require 'spec_helper'

describe 'ClassGroup Notes' do

  before { as :admin }
  before(:all) { set_resource 'class-group-note' }

  let(:class_group) { create(:class_group) }
  let(:class_group_with_note) { create(:class_group, :with_note) }

  context 'new', type: 'note' do
    before do
      @resource = class_group
      visit gaku.class_group_path(@resource)
    end

    it_behaves_like 'new note'
  end

  context 'existing', js: true, type: 'note'  do
    before do
      @resource = class_group_with_note
      visit gaku.class_group_path(@resource)
    end

    it_behaves_like 'edit note'
    it_behaves_like 'delete note'
  end

end
