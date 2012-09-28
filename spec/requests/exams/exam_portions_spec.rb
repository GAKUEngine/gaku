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
      within('#exam-exam_portions') { page.should have_content ("#{@exam.exam_portions.first.name}") }
      page.all('#exam-exam_portions table tbody tr').size.should == 1
    end

    it 'should add a portion', :js => true do
      find('#add_exam_exam_portion a').click
      wait_until { find('#exam_exam_portions_form').visible? }
      fill_in 'exam_exam_portions_attributes_1_name', :with => 'Ubuntu'
      click_on 'Create Exam portion'
      wait_until { page.all('#exam-exam_portions table tbody tr').size.should == 2 }
      @exam.exam_portions.count.should == 2
      #page.should have_content( 'Exam portions list ( 2 )' ) TODO
    end
    #TODO Test exam use weighting - show weighting widget
    #TODO Test exam not use weighting - hide weighting widget

    pending 'should edit a portion', :js => true do
      within("#exam-exam_portions table tbody tr"){ find('.edit-exam-portion-link').click }
      wait_until { find('#editExamPortionModal').visible? }
      fill_in 'exam_portion_name', :with => 'MacOS'
      click_on 'Save exam portion'
      wait_until { !find('#editExamPortionModal').visible? }
      within("#exam_portion_#{@exam.exam_portions.first.id}"){ page.should have_content('MacOS') } #TODO 
    end

    pending 'should show a portion' do
    end

    pending 'should delete a portion' do
    end


  end
end