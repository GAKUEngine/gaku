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
        flash_created?
      end.to change(Gaku::ExtracurricularActivity, :count).by 1

      page.should have_content 'Tennis'
      within(count_div) { page.should have_content 'Extracurricular Activities list(1)' }
    end

    it { has_validations? }

  end

  context 'existing' do
    before do
      extracurricular_activity
      visit gaku.extracurricular_activities_path
    end

    context 'edit' do

      context 'from edit view', js: true do
        before do
          visit gaku.edit_extracurricular_activity_path(extracurricular_activity)
        end

        it 'edits' do
          fill_in 'extracurricular_activity_name', with: 'Paintball'
          click submit
          flash_updated?

          expect(find_field('extracurricular_activity_name').value).to eq 'Paintball'


          extracurricular_activity.reload
          expect(extracurricular_activity.name).to eq 'Paintball'
        end

        it 'has validations' do
          fill_in 'extracurricular_activity_name', with: ''
          has_validations?
        end
      end

    end
  end

end
