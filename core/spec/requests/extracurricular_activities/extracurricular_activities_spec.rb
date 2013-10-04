require 'spec_helper'

describe 'Extracurricular Activities' do

  before { as :admin }

  let(:extracurricular_activity) { create(:extracurricular_activity, name: 'Tennis') }

  before :all do
    set_resource 'extracurricular-activity'
  end

  context 'new', js: true do
    before do
      visit gaku.extracurricular_activities_path
      click new_link
      wait_until_visible submit
    end

    it 'creates and shows' do
      expect do
        fill_in 'extracurricular_activity_name', with: 'Tennis'
        click submit
        wait_until_invisible form
      end.to change(Gaku::ExtracurricularActivity, :count).by 1

      page.should have_content 'Tennis'
      within(count_div) { page.should have_content 'Extracurricular Activities list(1)' }
      flash_created?
    end

    it { has_validations? }

    it 'cancels creating', cancel: true do
      ensure_cancel_creating_is_working
    end
  end

  context 'existing' do
    before do
      extracurricular_activity
      visit gaku.extracurricular_activities_path
    end

    context '#edit from show view', js: true do
      before do
        visit gaku.extracurricular_activity_path(extracurricular_activity)
        click edit_link
        wait_until_visible modal
      end

      it 'edits' do
        fill_in 'extracurricular_activity_name', with: 'Paintball'
        click submit
        wait_until_invisible modal

        page.should have_content 'Paintball'
        page.should_not have_content 'Tennis'

        extracurricular_activity.reload
        extracurricular_activity.name.should eq 'Paintball'
        flash_updated?
      end

      it 'has validations' do
        fill_in 'extracurricular_activity_name', with: ''
        has_validations?
      end

      it 'cancels editting', cancel: true do
        ensure_cancel_modal_is_working
      end

    end

    it 'deletes', js: true do

      expect do
        ensure_delete_is_working
      end.to change(Gaku::ExtracurricularActivity, :count).by -1

      page.should_not have_content("#{extracurricular_activity.name}")

    end
  end

end
