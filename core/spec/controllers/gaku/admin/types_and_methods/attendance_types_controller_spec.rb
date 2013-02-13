require 'spec_helper'

describe Gaku::Admin::AttendanceTypesController do

  as_admin

  let(:attendance_type) { create(:attendance_type) }

  describe "GET #index" do
    it "is successful" do
      gaku_js_get :index
      response.should be_success
    end

    it "populates an array of attendance_types" do
      gaku_js_get :index
      assigns(:attendance_types).should eq [attendance_type]
    end

    it "renders the :index view" do
      gaku_js_get :index
      response.should render_template :index
    end
  end

  describe 'GET #new' do
    it "assigns a new attendance_type to @attendance_type" do
      gaku_js_get :new, attendance_type_id: attendance_type.id
      assigns(:attendance_type).should be_a_new(Gaku::AttendanceType)
    end

    it "renders the :new template" do
        gaku_js_get :new, attendance_type_id: attendance_type.id
        response.should render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new attendance_type in the db" do
        expect{
          gaku_post :create, attendance_type: attributes_for(:attendance_type)
        }.to change(Gaku::AttendanceType, :count).by 1

        controller.should set_the_flash
      end
    end
    context "with invalid attributes" do
      it "does not save the new attendance_type in the db" do
        expect{
          gaku_js_post :create, attendance_type: {name: ''}
        }.to_not change(Gaku::AttendanceType, :count)
      end
    end
  end

  describe 'GET #edit' do
    it "locates the requested attendance_type" do
      gaku_js_get :edit, id: attendance_type
      assigns(:attendance_type).should eq(attendance_type)
    end

    it "renders the :edit template" do
        gaku_js_get :edit, id: attendance_type
        response.should render_template :edit
    end
  end

  describe "PUT #update" do
    it "locates the requested @attendance_type" do
      gaku_put :update, id: attendance_type, attendance_type: attributes_for(:attendance_type)
      assigns(:attendance_type).should eq(attendance_type)
    end

    context "valid attributes" do
      it "changes attendance_type's attributes" do
        gaku_put :update, id: attendance_type,attendance_type: attributes_for(:attendance_type, name: "Illness")
        attendance_type.reload
        attendance_type.name.should eq("Illness")

        controller.should set_the_flash
      end
    end
    context "invalid attributes" do
      it "does not change attendance_type's attributes" do
        gaku_js_put :update, id: attendance_type,
                              attendance_type: attributes_for(:attendance_type, name: "")
        attendance_type.reload
        attendance_type.name.should_not eq("")
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the attendance_type" do
      attendance_type
      expect{
        gaku_delete :destroy, id: attendance_type
      }.to change(Gaku::AttendanceType, :count).by -1

      controller.should set_the_flash
    end
  end

end
