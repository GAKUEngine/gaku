require 'spec_helper'

describe Gaku::Admin::AdmissionPeriodsController do

  let(:admission_period) { create(:admission_period) }

  describe "GET #index" do
    it "is successful" do
      gaku_get :index
      response.should be_success
    end

    it "populates an array of admission_periods" do
      gaku_get :index
      assigns(:admission_periods).should eq [admission_period]
    end

    it "renders the :index view" do
      gaku_get :index
      response.should render_template :index
    end
  end

    describe 'GET #show' do
    it "assigns the requested admission_period to @admission_period" do
      gaku_xhr_get :show, id: admission_period
      assigns(:admission_period).should eq admission_period
    end

    it "renders the :show template" do
      pending "need to resolve why is not rendering :show or remove test" do
        gaku_xhr_get :show, id: admission_period
        response.should render_template :show
      end
    end
  end

  describe 'GET #new' do
    it "assigns a new admission_period to @admission_period" do
      gaku_xhr_get :new
      assigns(:admission_period).should be_a_new(Gaku::AdmissionPeriod)
    end

    it "renders the :new template" do
      pending "need to resolve why is not rendering :new or remove test" do
        gaku_xhr_get :new
        response.should render_template :new
      end
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new admission period in the db" do
        expect{
          gaku_post :create, admission_period: attributes_for(:admission_period)  
        }.to change(Gaku::AdmissionPeriod, :count).by 1
        
        controller.should set_the_flash
      end
    end
    context "with invalid attributes" do
      it "does not save the new admission period in the db" do
        pending "need to make validations in model" do
          expect{
            gaku_post :create, admission_period: {name: ''}  
          }.to_not change(Gaku::AdmissionPeriod, :count)
        end
      end
    end
  end

  describe "PUT #update" do

    it "locates the requested @admission_period" do
      gaku_put :update, id: admission_period, admission_period: attributes_for(:admission_period) 
      assigns(:admission_period).should eq(admission_period)
    end

    context "valid attributes" do
      it "changes admission metod's attributes" do
        gaku_put :update, id: admission_period,admission_period: attributes_for(:admission_period, name: "AZ")
        admission_period.reload
        admission_period.name.should eq("AZ")

        controller.should set_the_flash
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the admission period" do
      @admission_period = create(:admission_period)
      expect{
        gaku_delete :destroy, id: @admission_period
      }.to change(Gaku::AdmissionPeriod, :count).by -1

      controller.should set_the_flash
    end
  end
end