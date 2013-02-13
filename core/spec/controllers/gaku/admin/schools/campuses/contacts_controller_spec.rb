require 'spec_helper'

describe Gaku::Admin::Schools::Campuses::ContactsController  do

  as_admin

  let(:contact) { create(:contact) }
  let(:school) { create(:school) }
  let(:campus) { create(:campus, school_id:school.id) }

  describe 'GET #new' do
    it "assigns a new contact to @contact" do
      gaku_js_get :new, school_id: school.id, campus_id: campus.id
      assigns(:contact).should be_a_new(Gaku::Contact)
    end

    it "renders the :new template" do
        gaku_js_get :new, school_id: school.id, campus_id: campus.id
        response.should render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new contact in the db" do
        expect{
          gaku_post :create, contact: attributes_for(:contact, contact_type_id:2), school_id: school.id, campus_id: campus.id
        }.to change(Gaku::Contact, :count).by 1

        controller.should set_the_flash
      end
    end
    context "with invalid attributes" do
      it "does not save the new contacts in the db" do
        expect{
          gaku_js_post :create, contact: {data: ''}, school_id: school.id, campus_id: campus.id
        }.to_not change(Gaku::Contact, :count)
      end
    end
  end

  describe 'GET #edit' do
    it "locates the requested contactes" do
      gaku_js_get :edit, id: contact, school_id: school.id, campus_id: campus.id
      assigns(:contact).should eq(contact)
    end

    it "renders the :edit template" do
        gaku_js_get :edit, id: contact, school_id: school.id, campus_id: campus.id
        response.should render_template :edit
    end
  end

  describe "PUT #update" do
    it "locates the requested @contacts" do
      gaku_put :update, id: contact, contact: attributes_for(:contact), school_id: school.id, campus_id: campus.id
      assigns(:contact).should eq(contact)
    end

    context "valid attributes" do
      it "changes contact's attributes" do
        gaku_put :update, id: contact,contact: attributes_for(:contact, contact_type_id:1, data: "123 123"), school_id: school.id, campus_id: campus.id
        contact.reload
        contact.data.should eq("123 123")

        controller.should set_the_flash
      end
    end
    context "invalid attributes" do
      it "does not change contact's attributes" do
        gaku_js_put :update, id: contact,
                              contact: attributes_for(:contact, data: ""), school_id: school.id, campus_id: campus.id
        contact.reload
        contact.data.should_not eq("")
      end
    end
  end


  describe "DELETE #destroy" do
    xit "deletes the contact" do
      contact
      campus
      school
      expect{
        gaku_delete :destroy, id: contact, school_id: school, campus_id: campus
      }.to change(Gaku::Contact, :count).by -1

      controller.should set_the_flash
    end
  end
end
