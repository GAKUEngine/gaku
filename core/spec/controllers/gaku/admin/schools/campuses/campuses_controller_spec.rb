require 'spec_helper'

describe Gaku::Admin::Schools::CampusesController do

  let(:school) { create(:school) }
  let(:campus) { create(:campus, school_id: school.id) }

  describe 'GET #new' do
    it "assigns a new campus to @campus" do
      gaku_js_get :new, school_id: school.id
      assigns(:campus).should be_a_new(Gaku::Campus)
    end

    it "renders the :new template" do
      gaku_js_get :new, school_id: school.id
      response.should render_template :new
    end
  end

  describe "POST #create" do
    before { school }

    context "with valid attributes" do
      it "saves the new campus in the db" do
        expect do
          gaku_post :create, campus: attributes_for(:campus), school_id: school
        end.to change(Gaku::Campus, :count).by 1

        controller.should set_the_flash
      end
    end

    context "with invalid attributes" do
      it "does not save the new campus in the db" do
        expect do
          gaku_js_post :create, campus: { name: '' }, school_id: school
        end.to_not change(Gaku::Campus, :count)
      end
    end
  end

  describe 'GET #edit' do
    it "locates the requested campus" do
      gaku_js_get :edit, id: campus, school_id: school.id
      assigns(:campus).should eq campus
    end

    it "renders the :edit template" do
      gaku_js_get :edit, id: campus, school_id: school.id
      response.should render_template :edit
    end
  end

  describe "PUT #update" do
    it "locates the requested @campus" do
      gaku_put :update, id: campus, campus: attributes_for(:campus), school_id: school
      assigns(:campus).should eq campus
    end

    context "valid attributes" do
      it "changes campus's attributes" do
        gaku_put :update, id: campus, campus: attributes_for(:campus, name: "UE Varna"), school_id: school
        campus.reload
        campus.name.should eq "UE Varna"

        controller.should set_the_flash
      end
    end

    context "invalid attributes" do
      it "does not change campus's attributes" do
        gaku_js_put :update, id: campus,
                             campus: attributes_for(:campus, name: ""), school_id: school
        campus.reload
        campus.name.should_not eq ""
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the campus" do
      campus

      expect do
        gaku_delete :destroy, id: campus, school_id: school.id
      end.to change(Gaku::Campus, :count).by -1

      controller.should set_the_flash
    end
  end

end
