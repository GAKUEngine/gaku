require 'spec_helper'

describe 'Syllabus' do

  as_admin

  let(:syllabus) { create(:syllabus, name: 'Biology', code: 'bio') }

  before do
    set_resource "syllabus"
  end

  context '#new ', js: true do

    before do
      visit gaku.syllabuses_path
      click new_link
      wait_until_visible submit
    end

    it "creates" do
      tr_count = size_of(table_rows)
      expect do
        fill_in "syllabus_name", with: "Syllabus1"
        fill_in "syllabus_code", with: "code1"
        fill_in "syllabus_description", with: "Syllabus Description"
        click submit
        wait_until_invisible submit
      end.to change(Gaku::Syllabus, :count).by 1

      page.find(new_link).visible?
      size_of(table_rows).should eq tr_count+1
    end

    it {has_validations?}

    it "cancels adding" do
      ensure_cancel_creating_is_working
    end

  end

  context 'existing' do

    before do
      syllabus
      visit gaku.syllabuses_path
    end

    context "lists" do

      it "lists existing syllabuses" do
        page.should have_content("List Syllabuses")

        within(table) {
          page.should have_content("Biology")
          page.should have_content("bio")
        }
        size_of(table_rows).should eq 2
      end

      it 'shows' do
        within(table) { click show_link }
        current_path.should == "/syllabuses/#{syllabus.id}"
      end

    end

    context '#edit ', js: true do

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
        fill_in "syllabus_name", with: "Maths"
        fill_in "syllabus_code", with: "math"
        fill_in "syllabus_description", with: "Maths Description"

        click submit

        page.should have_content("Maths")
        page.should have_content("math")

        page.should_not have_content "Biology"
        page.should_not have_content 'bio'

        edited_syllabus = Gaku::Syllabus.last
        edited_syllabus.name.should eq 'Maths'
        edited_syllabus.code.should eq 'math'
        edited_syllabus.description.should eq 'Maths Description'
        flash_updated?
      end

      it 'cancels editting' do
        ensure_cancel_modal_is_working
      end

      it 'edits from show view' do
        visit gaku.syllabus_path(syllabus)
        click edit_link
        wait_until_visible modal

        fill_in "syllabus_name", with: "Maths"
        fill_in "syllabus_code", with: "math"
        fill_in "syllabus_description", with: "Maths Description"

        click submit

        page.should have_content("Maths")
        page.should have_content("math")

        page.should_not have_content "Biology"
        page.should_not have_content 'bio'

        edited_syllabus = Gaku::Syllabus.last
        edited_syllabus.name.should eq 'Maths'
        edited_syllabus.code.should eq 'math'
        edited_syllabus.description.should eq 'Maths Description'
        flash_updated?
      end
    end

    it "deletes", js: true do

      expect do
        ensure_delete_is_working
      end.to change(Gaku::Syllabus, :count).by -1

      page.should_not have_content("#{syllabus.code}")

    end

  end

end
