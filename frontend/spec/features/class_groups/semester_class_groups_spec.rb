require 'spec_helper'

describe 'ClassGroup Semesters' do

  before { as :admin }

  let(:class_group) { create(:class_group) }
  let(:school_year) { create(:school_year, starting: Date.parse('2013-1-1'), ending: Date.parse('2013-12-30')) }
  let(:semester) { create(:semester, school_year: school_year, starting: Date.parse('2013-1-1'), ending: Date.parse('2013-6-1')  )}
  let(:semester2) { create(:semester, school_year: school_year, starting: Date.parse('2013-6-1'), ending: Date.parse('2013-12-30')  )}
  let(:semester_class_group) { create(:semester_class_group, semester: semester, class_group: class_group)}

  before :all do
    set_resource 'class-group-semester-class-group'
  end

  before do
    class_group
  end

  context 'new', js: true do
    before do
      semester
      visit gaku.edit_class_group_path(class_group)
      click tab_link
      click new_link
    end

    it 'creates and shows' do
      expect do
        select "#{semester.starting} / #{semester.ending}", from: 'semester_class_group_semester_id'
        click submit
        flash_created?
      end.to change(Gaku::SemesterClassGroup, :count).by(1)

      within(table) { page.should have_content "#{semester.starting} / #{semester.ending}" }
      within(tab_link) { page.should have_content 'Semesters(1)' }

    end

    it 'presence validations'  do
      has_validations?
    end

    it 'uniqness scope validations'  do
      semester_class_group
      expect do
        select "#{semester.starting} / #{semester.ending}", from: 'semester_class_group_semester_id'
        click submit
      end.to change(Gaku::SemesterClassGroup, :count).by(0)
      page.should have_content('Semester already added to Class Group')
    end

  end

  context 'existing' do
    before do
      semester
      semester2
      semester_class_group
      visit gaku.edit_class_group_path(class_group)
      click tab_link
    end

    context 'edit', js: true do
      before do
        within(table) { click js_edit_link }
        visible? modal
      end

      it 'edits' do
        select "#{semester2.starting} / #{semester2.ending}", from: 'semester_class_group_semester_id'
        click submit

        flash_updated?
        within(table) { page.should have_content "#{semester2.starting} / #{semester2.ending}" }
        within(table) { page.should_not have_content "#{semester.starting} / #{semester.ending}" }
      end

    end

    it 'delete', js: true do
      within(table)     { page.should have_content "#{semester.starting} / #{semester.ending}" }
      within(tab_link)  { page.should have_content 'Semesters(1)' }

      expect do
        ensure_delete_is_working
        flash_destroyed?
      end.to change(Gaku::SemesterClassGroup,:count).by -1

      within(table)     { page.should_not have_content "#{semester.starting} / #{semester.ending}" }
      within(tab_link) { page.should_not have_content 'Semesters(1)' }
      within(tab_link) { page.should have_content 'Semesters' }
    end
  end
end