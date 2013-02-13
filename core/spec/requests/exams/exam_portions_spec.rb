require 'spec_helper'

describe 'Exam portions' do

  as_admin

  let(:exam) { create(:exam, :name => "Unix") }

  before :all do
    set_resource "exam-exam-portion"
  end

  context 'exam/show ' do
    before do
      visit gaku.exam_path(exam)
      exam.exam_portions.count.should eq 1
      within (count_div) { page.should have_content 'Exam portions list(1)' }
    end

    context '#add ', :js => true do
      before do
        click new_link
        wait_until_visible submit
      end

      it 'adds a portion' do
        expect do
          fill_in "exam_portion_name", :with => 'Ubuntu'
          fill_in 'exam_portion_weight', :with => 100.6
          click submit
          wait_until_invisible form
        end.to change(exam.exam_portions,:count).by 1

        within(count_div) { page.should have_content 'Exam portions list(2)' }
        size_of(table_rows).should == 3
        within (table) { page.should have_content "Ubuntu" }
        page.should have_content 'Ubuntu Weight'
        page.should have_content 'Total Weight'
        within('#weight-total') { page.should have_content "200.6" }
        #TODO flash_created?
      end

      it 'cancels adding', :cancel => true do
        ensure_cancel_creating_is_working
      end
    end


    it 'edits a portion', :js => true do
      within(table){ click edit_link }
      wait_until_visible modal
      fill_in 'exam_portion_name', :with => 'MacOS'
      fill_in 'exam_portion_weight', :with => 50.6
      click submit

      wait_until_invisible modal
      within(table){
        page.should have_content 'MacOS'
        page.should have_content '50.6'
      }
      within('#weight-total'){ page.should have_content "50.6" }
      flash_updated?
    end

    it 'shows a portion' do
      click show_link
      page.should have_content 'Show Exam Portion'
    end

    it 'deletes exam portion', :js => true do
      create(:exam_portion, :exam => exam)

      weight_total = find('#weight-total').text
      exam_portion_name = exam.exam_portions.first.name

      expect do
        ensure_delete_is_working
      end.to change(Gaku::ExamPortion, :count).by -1

      exam.exam_portions.count.should == 1

      within(count_div) { page.should have_content 'Exam portions list(1)' }
      #FIXME
      #page.should_not have_content "#{exam_portion_name} Weight"
      #within('#weight-total') { page.should_not have_content "#{weight_total}" }
      flash_destroyed?
    end

    it 'deletes the last portion', :js => true do
      exam_portion_name = exam.exam_portions.first.name

      expect do
        within(table) { click delete_link }
        accept_alert
        #FIXME
        sleep 0.5
      end.to change(Gaku::ExamPortion, :count).by -1

      Gaku::Exam.count.should eq 0
      current_path.should == "/exams"
      flash_destroyed?
    end

    context 'when select back' do
      it 'returns to exams/index page' do
        click_on 'Back'
        current_path.should == "/exams"
      end
    end

  end

end
