require 'spec_helper'

describe 'Syllabus' do

  before { as :admin }
  before(:all) { set_resource 'syllabus' }

  let(:syllabus) { create(:syllabus, name: 'Biology', code: 'bio') }
  let(:department) { create(:department) }

  context 'new', js: true do

    before do
      department
      visit gaku.syllabuses_path
      click new_link
      wait_until_visible submit
    end

    it 'creates' do
      expect do
        fill_in 'syllabus_name', with: 'Syllabus1'
        fill_in 'syllabus_code', with: 'code1'
        fill_in 'syllabus_description', with: 'Syllabus Description'
        select department.name, from: 'syllabus_department_id'
        click submit
        wait_until_invisible submit
      end.to change(Gaku::Syllabus, :count).by 1
      within(table) do
        has_content? 'Syllabus1'
        has_content? 'code1'
        has_content? department.name
      end
      count? '1'
    end

    it { has_validations? }
  end

  context 'existing' do

    before { syllabus }

    context 'edit', js: true do

      context 'from edit view' do
        it 'edits' do
          visit gaku.edit_syllabus_path(syllabus)

          fill_in 'syllabus_name', with: 'Maths'
          fill_in 'syllabus_code', with: 'math'
          fill_in 'syllabus_description', with: 'Maths Description'

          click submit
          flash_updated?

          expect(find_field('syllabus_name').value).to eq 'Maths'
          expect(find_field('syllabus_code').value).to eq 'math'
          expect(find_field('syllabus_description').value).to eq 'Maths Description'

          syllabus.reload
          expect(syllabus.name).to eq 'Maths'
          expect(syllabus.code).to eq 'math'
          expect(syllabus.description).to eq 'Maths Description'
        end
      end

    end

  end
end
