require 'spec_helper'

describe 'Student Contacts' do

  stub_authorization!

  before :all do 
    Helpers::Request.resource("student-contact")
  end

  before do
    @student = create(:student)
    @contact_type = create(:contact_type, :name => 'email')
  end

  context 'new', :js => true do 
    before do 
      visit gaku.student_path(@student) 
      click new_link
      wait_until_visible submit
    end

    it "adds and shows" do
      expect do 
        select 'email',            :from => 'contact_contact_type_id'
        fill_in "contact_data",    :with => "The contact data"
        fill_in "contact_details", :with => "The contact details"
        click submit
        wait_until_invisible form
      end.to change(@student.contacts, :count).by 1 
      
      page.should have_content "The contact data"
      page.should have_content "The contact details"
      within(count_div) { page.should have_content 'Contacts list(1)' }
      flash_created?
    end

    it 'cancels creating' do
      ensure_cancel_creating_is_working
    end
  end


  context "existing" do 
    before(:each) do 
      @contact = create(:contact, :contact_type => @contact_type)
      @student.contacts << @contact 
    end

    context 'edit', :js => true do 
      before do 
        visit gaku.student_path(@student)
        within(table) { click edit_link }
        wait_until_visible modal
      end

      it "edits" do 
        fill_in 'contact_data', :with => 'example@genshin.org'
        click submit

        wait_until_invisible modal
        page.should have_content 'example@genshin.org'
        flash_updated?
      end

      it 'cancels editting' do 
        ensure_cancel_modal_is_working
      end
    end


    it "sets primary", :js => true do 
      contact2 = create(:contact, :data => 'gaku2@example.com', :contact_type => @contact_type)
      @student.contacts << contact2
      
      visit gaku.student_path(@student) 
     
      @student.contacts.first.is_primary? == true
      @student.contacts.second.is_primary? == false

      within("#{table} tr#contact-2") { click_link 'set-primary-link' }
      accept_alert

      @student.contacts.first.is_primary? == false
      @student.contacts.second.is_primary? == true
    end

    it "delete primary", :js => true do
      contact2 = create(:contact, :data => 'gaku2@example.com', :contact_type => @contact_type)
      @student.contacts << contact2

      contact1_tr = "#contact-#{@contact.id}"
      contact2_tr = "#contact-#{contact2.id}"
      
      visit gaku.student_path(@student)

      click "#{contact2_tr} td.primary-button a"
      accept_alert
      page.find("#{contact2_tr} td.primary-button a.btn-primary")

      click "#{contact2_tr} .delete-link"
      accept_alert
      
      page.find("#{contact1_tr} .primary-button a.btn-primary")
      @student.contacts.first.is_primary? == true 
    end

    it "deletes", :js => true do
      visit gaku.student_path(@student)

      within(count_div) { page.should have_content 'Contacts list(1)' }
      page.should have_content @contact.data
       
      expect do 
        ensure_delete_is_working
      end.to change(@student.contacts, :count).by -1
      
      within(count_div) { page.should_not have_content 'Contacts list(1)' }
      page.should_not have_content @contact.data
      flash_destroyed?
    end
  end
end
