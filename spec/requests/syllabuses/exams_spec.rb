require 'spec_helper'

describe 'Syllabus Exams' do
 
  existing_exam_form           = '#new-existing-exam'
  new_existing_exam_link       = '#new-existing-exam-link'
  submit_existing_exam_button  = '#submit-existing-exam-button'
  cancel_existing_exam_link    = '#cancel-existing-exam-link'

  stub_authorization!

  before :all do
    Helpers::Request.resource('syllabus-exam') 
  end

  before do
    @exam = create(:exam)
    @syllabus = create(:syllabus, :name => 'Biology', :code => 'bio')
    visit syllabuses_path
  end

  context "existing exam" do
    before do
      within('table.index tr:nth-child(2)') { click show_link }
      page.should have_content "No Exams"
    end

    it "adds existing exam to syllabus", :js => true do
      click new_existing_exam_link 
      wait_until_visible submit_existing_exam_button
      
      select @exam.name, :from => 'exam_syllabus_exam_id'
      click submit_existing_exam_button      
      
      #ensure_create_is_working table_rows

      page.should have_content @exam.name
      flash("Exam added to Syllabus")     

      wait_until_invisible existing_exam_form
    end 

    it "cancels adding existing exam to syllabus", :js => true do
      click new_existing_exam_link 
      wait_until_visible submit_existing_exam_button
      invisible? new_existing_exam_link
      
      click cancel_existing_exam_link
      wait_until_invisible existing_exam_form
      visible? new_existing_exam_link
    end
  end

  context "new exam" do
    context 'new' do 
      before do 
        within('table.index tr:nth-child(2)') { click show_link }
        page.should have_content "No Exams"
        click new_link
        wait_until_visible submit
      end

      it "creates and shows exams", :js => true  do    
        expect do  
          #required
          fill_in 'exam_name', :with => 'Biology Exam'
          fill_in 'exam_exam_portions_attributes_0_name' , :with => 'Biology Exam Portion'
          click submit
          wait_until_invisible form
        end.to change(@syllabus.exams, :count).by 1

        page.should have_content "Biology Exam"
        page.should_not have_content "No Exams"
      end

      it 'errors if the required fields are empty', :js => true do 
        fill_in 'exam_exam_portions_attributes_0_name', :with => ''
        click submit

        wait_until do 
          page.should have_selector 'div.exam_nameformError' 
          page.should have_selector 'div.exam_exam_portions_attributes_0_nameformError' 
        end

        @syllabus.exams.count.should eq 0
      end

      it "cancels creating", :js => true do
        ensure_cancel_creating_is_working
      end
    end

    context 'created exam' do 
      before do 
        @exam = create(:exam, :name => 'Astronomy Exam')
        @syllabus.exams << @exam
        visit syllabus_path(@syllabus)
      end

      it 'edits exam' do 
        click edit_link
        current_url.should eq edit_exam_url(:id => @exam.id)
        fill_in 'exam_name', :with => 'Ruby Exam'
        
        #click submit_button
        click_button 'submit_button' #FIXME Fix this id

        page.should have_content 'Ruby Exam'
        current_url.should eq exam_url(:id => @exam.id)
      end

      it 'shows exam'  do 
        click show_link
        page.should have_content 'Show Exam'
        page.should have_content 'Exam portions list'
        page.should have_content 'Astronomy Exam'
        current_url.should == exam_url(:id => @exam.id)
      end

      it 'deletes exam', :js => true do
        page.should have_content @exam.name
         
        expect do 
          ensure_delete_is_working
        end.to change(@syllabus.exams, :count).by -1
     
        page.should_not have_content @exam.name 
      end
    end
  end

  context 'links hiding' do
    before do 
      within('table.index tr:nth-child(2)') { click show_link }
    end

    it "clicking on new-existing-exam-link hides new-exam-form", :js => true do
      click new_link
      wait_until_visible form
      
      click new_existing_exam_link 
      wait_until_visible existing_exam_form
      invisible? new_existing_exam_link
      
      wait_until_invisible form
      visible? new_link
    end

    it "click on new-syllabus-exam-link hide add-existing-exam form when is visible", :js => true do
      click new_existing_exam_link
      wait_until_visible existing_exam_form

      click new_link
      wait_until_visible form
      invisible? new_link

      wait_until_invisible existing_exam_form
      visible? new_existing_exam_link
    end
  end

end