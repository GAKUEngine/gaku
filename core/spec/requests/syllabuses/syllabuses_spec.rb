require 'spec_helper'

describe 'Syllabus' do

  before { as :admin }
  before(:all) { set_resource 'syllabus' }

  let(:syllabus) { create(:syllabus, name: 'Biology', code: 'bio') }

  context 'new', js: true do

    before do
      visit gaku.syllabuses_path
      click new_link
      wait_until_visible submit
    end

    it 'creates' do
      expect do
        fill_in 'syllabus_name', with: 'Syllabus1'
        fill_in 'syllabus_code', with: 'code1'
        fill_in 'syllabus_description', with: 'Syllabus Description'
        click submit
        wait_until_invisible submit
      end.to change(Gaku::Syllabus, :count).by 1

      has_content? 'Syllabus1'
      has_content? 'code1'
      count? '1'
    end

    it {has_validations?}
  end

  context 'existing' do

    before do
      syllabus
      visit gaku.syllabuses_path
    end

    context 'edit', js: true do

      before do
        syllabus
        click edit_link
        wait_until_visible modal
      end

      it 'has validations' do
        fill_in 'syllabus_name', with: ''
        has_validations?
      end

      it 'edits' do
        fill_in 'syllabus_name', with: 'Maths'
        fill_in 'syllabus_code', with: 'math'
        fill_in 'syllabus_description', with: 'Maths Description'

        click submit
        flash_updated?

        has_content? 'Maths'
        has_content? 'math'

        has_no_content? 'Biology'
        has_no_content? 'bio'

        expect(syllabus.reload.name).to eq 'Maths'
      end


      it 'edits from show view' do
        visit gaku.syllabus_path(syllabus)
        click edit_link
        wait_until_visible modal

        fill_in 'syllabus_name', with: 'Maths'
        fill_in 'syllabus_code', with: 'math'
        fill_in 'syllabus_description', with: 'Maths Description'

        click submit

        has_content?('Maths')
        has_content?('math')

        has_no_content? 'Biology'
        has_no_content? 'bio'

        edited_syllabus = Gaku::Syllabus.last
        edited_syllabus.name.should eq 'Maths'
        edited_syllabus.code.should eq 'math'
        edited_syllabus.description.should eq 'Maths Description'
        flash_updated?
      end
    end

    it 'deletes', js: true do

      expect do
        ensure_delete_is_working
      end.to change(Gaku::Syllabus, :count).by -1

      has_no_content?("#{syllabus.code}")

    end

  end

end
