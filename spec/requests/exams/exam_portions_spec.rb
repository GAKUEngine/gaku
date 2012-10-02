require 'spec_helper'

describe 'Exam portions' do
  stub_authorization!

  context 'exam/show' do
    before do
      @exam = Factory(:exam, :name => "Unix")
      visit exam_path(@exam)
      Exam.count.should == 1
      @exam.exam_portions.count.should == 0
      page.should have_content( 'Exam portions list ( 0 )' )
      
    end

    it 'should add a portion', :js => true do
      find('#add_exam_exam_portion a').click
      wait_until { find('#exam_exam_portions_form').visible? }
      fill_in 'exam_exam_portions_attributes_1_name', :with => 'Ubuntu'
      fill_in 'exam_exam_portions_attributes_1_weight', :with => 100.6
      click_on 'Create Exam portion'
      wait_until { !find('#exam_exam_portions_form').visible? }
      @exam.exam_portions.count.should == 1
      page.should have_content( 'Exam portions list ( 1 )' )
      
      page.all('#exam-exam_portions table tbody tr').size.should == 1
      within('#exam-exam_portions') { page.should have_content ("#{@exam.exam_portions.first.name}") }
      page.should have_content("#{@exam.exam_portions.first.name}"+' Weight')
      page.should have_content('Total Weight')
      within('#weight-total'){ page.should have_content ("100.6") }
    end

    pending 'should show weighting widget' do

    end

    pending 'should hide weighting widget' do
    end

    #TODO Test exam use weighting - show weighting widget
    #TODO Test exam not use weighting - hide weighting widget

    it 'should edit a portion', :js => true do
      within("#exam-exam_portions table tbody tr"){ find('.edit-exam-portion-link').click }
      wait_until { find('#editExamPortionModal').visible? }
      fill_in 'exam_portion_name', :with => 'MacOS'
      click_on 'Save exam portion'
      wait_until { !find('#editExamPortionModal').visible? }
      within("#exam_portion_#{@exam.exam_portions.first.id}"){ page.should have_content('MacOS') } 
    end

    pending 'should show a portion' do
    end
    
    it 'should delete a portion', :js => true do
      exam_portion_id = @exam.exam_portions.first.id
      within("#exam-exam_portions table tbody tr"){ find('.delete-exam-portion-link').click }
      page.driver.browser.switch_to.alert.accept
      wait_until { !page.find("#exam_portion_#{exam_portion_id}").visible? }
      @exam.exam_portions.count.should == 0
      page.should have_content( 'Exam portions list ( 0 )' )
    end


  end
end