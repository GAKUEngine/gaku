require 'spec_helper'

describe Gaku::Admin::Schools::Campuses::AddressesController do

  let(:address) { create(:address) }
  let(:school) { create(:school) }
  let(:country) { create(:country) }
  let(:campus) { create(:campus, school_id: school.id) }
  let(:valid_attributes)   { {address1: "Address#1", city: "Nagoya", country: country} }
  let(:invalid_attributes) { {address1: ''} }

  describe 'GET #new' do
    it "assigns a new address to @address" do
      gaku_js_get :new, school_id: school.id, campus_id: campus.id
      assigns(:address).should be_a_new(Gaku::Address)
    end

    it "renders the :new template" do
      gaku_js_get :new, school_id: school.id, campus_id: campus.id
      response.should render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new address in the db" do
        expect do
          gaku_js_post :create, address: valid_attributes, school_id: school.id, campus_id: campus.id
        end.to change(Gaku::Address, :count).by 1

        #controller.should set_the_flash
      end
    end
    context "with invalid attributes" do
      it "does not save the new addresses in the db" do
        expect do
          gaku_js_post :create, address: invalid_attributes, school_id: school.id, campus_id: campus.id
        end.to_not change(Gaku::Address, :count)
      end
    end
  end

  describe 'GET #edit' do
    it "locates the requested addresses" do
      gaku_js_get :edit, id: address, school_id: school.id, campus_id: campus.id
      assigns(:address).should eq(address)
    end

    it "renders the :edit template" do
        gaku_js_get :edit, id: address, school_id: school.id, campus_id: campus.id
        response.should render_template :edit
    end
  end

  describe "PUT #update" do
    it "locates the requested @address" do
      gaku_js_put :update, id: address, school_id: school.id, campus_id: campus.id
      assigns(:address).should eq(address)
    end

    context "valid attributes" do
      it "changes addresses's attributes" do
        gaku_js_put :update, id: address, address: valid_attributes, school_id: school.id, campus_id: campus.id
        address.reload
        address.city.should eq "Nagoya"

        #controller.should set_the_flash
      end
    end
    context "invalid attributes" do
      it "does not change addresses's attributes" do
        gaku_js_put :update, id: address,
                              address: attributes_for(:address, city: ""), school_id: school.id, campus_id: campus.id
        address.reload
        address.city.should_not eq("")
      end
    end
  end


  describe "DELETE #destroy" do
    xit "deletes the address" do
      address
      school
      expect{
        gaku_delete :destroy, id: address, school_id: school, campus_id: campus
      }.to change(Gaku::Address, :count).by -1

      controller.should set_the_flash
    end
  end

end
