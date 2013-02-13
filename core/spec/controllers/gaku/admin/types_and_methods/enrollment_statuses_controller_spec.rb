require 'spec_helper'

describe Gaku::Admin::EnrollmentStatusesController do

  as_admin

  let(:enrollment_status) { create(:enrollment_status) }

  describe "GET #index" do

    before { gaku_js_get :index }

    it { should respond_with(:success) }
    it("assigns") { assigns(:enrollment_statuses).should eq [enrollment_status] }
    it("renders") { response.should render_template :index }
  end

  describe 'GET #new' do
    it "assigns @enrollment_status" do
      gaku_js_get :new, name: "Enrolled"
      assigns(:enrollment_status).should be_a_new(Gaku::EnrollmentStatus)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new enrollment status in the db" do
        expect do
          gaku_post :create, enrollment_status: attributes_for(:enrollment_status, name: "Edited name")
        end.to change(Gaku::EnrollmentStatus, :count).by 1

        controller.should set_the_flash
      end
    end
    context "with invalid attributes" do
      it "does not save the new contact type in the db" do
        expect do
          gaku_js_post :create, enrollment_status: attributes_for(:enrollment_status, name: "")
        end.to_not change(Gaku::EnrollmentStatus, :count)
      end
    end
  end

  describe 'GET #edit' do
    before { gaku_js_get :edit, id: enrollment_status }

    it("locates enrollment status") { assigns(:enrollment_status).should eq(enrollment_status) }
    it("renders") { response.should render_template :edit }
  end

  describe "PUT #update" do
    it "locates the requested @enrollment_status" do
      gaku_put :update, id: enrollment_status,
                        name: "Test"
      assigns(:enrollment_status).should eq(enrollment_status)
    end

    context "valid attributes" do
      it "changes enrollment status attributes" do
        gaku_js_put :update, id: enrollment_status,
                             enrollment_status: attributes_for(:enrollment_status, name: "Edited name")
        enrollment_status.reload
        enrollment_status.name.should eq "Edited name"
      end
    end

    context "invalid attributes" do
      it "does not change contact type's attributes" do
        gaku_js_put :update, id: enrollment_status,
                    enrollment_status: attributes_for(:enrollment_status, name: "")
        enrollment_status.reload
        enrollment_status.name.should_not eq ""
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the enrollment status" do
      enrollment_status
      expect do
        gaku_delete :destroy, id: enrollment_status
      end.to change(Gaku::EnrollmentStatus, :count).by -1

      controller.should set_the_flash
    end
  end

end
