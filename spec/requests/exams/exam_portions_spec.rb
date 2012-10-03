require 'spec_helper'

describe 'Exam portions' do
  stub_authorization!

  context 'exam/show' do
    before do
      @exam = Factory(:exam, :name => "Unix")
      visit exam_path(@exam)
      Exam.count.should == 1
      @exam.exam_portions.count.should == 1
      page.should have_content( 'Exam portions list ( 1 )' )
      
    end

    it 'should add a portion', :js => true do
      find('#add_exam_exam_portion a').click
      wait_until { find('#exam_exam_portions_form').visible? }
      fill_in "exam_exam_portions_attributes_1_name", :with => 'Ubuntu'
      fill_in 'exam_exam_portions_attributes_1_weight', :with => 100.6
      click_on 'Create Exam portion'
      wait_until { !find('#exam_exam_portions_form').visible? }
      @exam.exam_portions.count.should == 2
      page.should have_content( 'Exam portions list ( 2 )' )
      page.all('#exam-exam_portions table tbody tr').size.should == 2
      within('#exam-exam_portions') { page.should have_content ("Ubuntu") }
      page.should have_content('Ubuntu Weight')
      page.should have_content('Total Weight')
      within('#weight-total'){ page.should have_content ("200.6") }
    end

    it 'should edit a portion', :js => true do
      within("#exam-exam_portions table tbody tr"){ find('.edit-exam-portion-link').click }
      wait_until { find('#editExamPortionModal').visible? }
      fill_in 'exam_portion_name', :with => 'MacOS'
      fill_in 'exam_portion_weight', :with => 50.6
      click_on 'Save exam portion'
      wait_until { !find('#editExamPortionModal').visible? }
      within("#exam-exam_portions"){ page.should have_content('MacOS') }
      within("#exam-exam_portions"){ page.should have_content('50.6') }
      within('#weight-total'){ page.should have_content ("50.6") }
    end

    it 'should show a portion' do
      find('.show-exam-portion-link').click
      page.should have_content('Show Exam Portion')
    end
    
    it 'should delete a portion', :js => true do
      weight_total = find('#weight-total').text
      exam_portion_name = @exam.exam_portions.first.name
      within("#exam-exam_portions table tbody tr"){ find('.delete-exam-portion-link').click }
      page.driver.browser.switch_to.alert.accept
      wait_until { !page.find("#exam-exam_portions table tbody tr").visible? }
      @exam.exam_portions.count.should == 0
      page.should have_content( 'Exam portions list ( 0 )' )
      page.should_not have_content("#{exam_portion_name} Weight")
      within('#weight-total'){ page.should_not have_content ("#{weight_total}") }
    end

  end

end