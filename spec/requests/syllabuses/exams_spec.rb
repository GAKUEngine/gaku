require 'spec_helper'

describe 'Syllabus Exams' do
  stub_authorization!

  before do
    @exam = create(:exam)
    @syllabus = create(:syllabus, :name => 'Biology', :code => 'bio')
    visit syllabuses_path
  end

  context "add and show exams" do
    before do 
      within('table.index tr:nth-child(2)') { find(".show-link").click }
      page.should have_content("No Exams")
      click_link 'new-syllabus-exam-link'
      wait_until { find('#new-syllabus-exam').visible? }
    end

    it "should add and show exams", :js => true  do
      @syllabus.exams.count.should eql(0)
      #required
      fill_in 'exam_name', :with => 'Biology Exam'
      fill_in 'exam_exam_portions_attributes_0_name' , :with => 'Biology Exam Portion'
      click_button 'submit-syllabus-exam-button'

      wait_until { !page.find('#new-syllabus-exam').visible? }
      page.should have_content('Biology Exam')
      page.should_not have_content("No Exams")
      @syllabus.exams.count.should eql(1)
    end

    it 'should error if the required fields are empty', :js => true do 
      fill_in 'exam_exam_portions_attributes_0_name', :with => ''
      click_button 'submit-syllabus-exam-button'

      wait_until do 
        page.should have_selector('div.exam_nameformError') 
        page.should have_selector('div.exam_exam_portions_attributes_0_nameformError') 
      end

      @syllabus.exams.count.should eql(0)
    end

    it "add existing exam to syllabus", :js => true do

      click_link "add-existing-exam-link" 
      wait_until_visible('#submit-existing-exam-to-syllabus')
      
      select @exam.name, :from => 'exam_syllabus_exam_id'
      click_button "submit-existing-exam-to-syllabus"      
      
      ensure_create_is_working('table#syllabus-exams-index tr')
      page.find('#syllabus-exams-index').should have_content(@exam.name)
      flash("Exam added to Syllabus")     

      wait_until_invisible('#add-existing-exam') 
    end 
  end

  context 'show, edit, delete' do 
    before do 
      @exam = create(:exam, :name => 'Astronomy Exam')
      @syllabus.exams << @exam
      visit syllabus_path(@syllabus)
    end

    it 'should edit exam' do 
      find('.edit-link').click
      current_url.should == edit_exam_url(:id => @exam.id)
      fill_in 'exam_name', :with => 'Ruby Exam'
      click_button 'submit_button' #FIXME Fix this id

      page.should have_content('Ruby Exam')
      current_url.should == exam_url(:id => @exam.id)
    end

    it 'should show exam'  do 
      find('.show-link').click
      page.should have_content('Show Exam')
      page.should have_content('Exam portions list')
      page.should have_content('Astronomy Exam')
      current_url.should == exam_url(:id => @exam.id)
    end

    it 'should delete a syllabus exam', :js => true do
      @syllabus.exams.size.should eql(1)
      tr_count = page.all('table#syllabus-exams-index tr').size
      page.should have_content(@exam.name)

      find(".delete-link").click 
      page.driver.browser.switch_to.alert.accept
      wait_until { page.all('table#syllabus-exams-index tr').size == tr_count - 1 }
      page.all('table#syllabus-exams-index').should_not have_content(@exam.name) 
      @syllabus.exams.reload 
      @syllabus.exams.size.should eql(0) 
    end
  end



  
end