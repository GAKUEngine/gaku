require 'spec_helper'

describe 'Students in admissions' do

  as_admin

  let(:student) { create(:student, name: 'John', surname: 'Doe') }
  let(:student2) { create(:student, name: 'Susumu', surname: 'Yokota') }
  let(:student3) { create(:student, name: 'Johny', surname: 'Bravo') }

  before :all do
    set_resource "student"
  end

  context "existing", js:true do
    
    before do
      student
      student2
      student3
      visit gaku.admin_student_path(id:student.id)
    end

    context 'when select edit btn' do
      
      before do
        click edit_link
        wait_until_visible modal
      end

      it "edits " do
        fill_in "student_surname", with: "Kostova"
        fill_in "student_name",    with: "Marta"
        click submit
        wait_until_invisible modal
        page.should have_content "Kostova"
        page.should have_content "Marta"
        student.reload
        student.name.should eq "Marta"
        student.surname.should eq "Kostova"
        flash_updated?
      end

      it 'cancels editting', cancel: true do
        ensure_cancel_modal_is_working
      end

    end

    context 'when click on back' do

      xit 'returns to index' do
        click_on 'Back'
      end

    end

    context 'shows picture' do

      it 'shows picture' do
        page.should have_css '#avatar-picture'
      end

      it "uploads" do
        click_button "Change picture"
        absolute_path = Rails.root + "../support/120x120.jpg"
        attach_file 'student_picture', absolute_path
        click_button "Upload"
        flash? "successfully uploaded"
      end
      
    end


    context 'shows contacts' do
      
    end
    context 'shows notes' do
      
    end

    context 'shows addresses' do
      
    end

    context 'shows guardians' do
      
    end
  end
end
