require 'spec_helper'

describe Gaku::Admin::AdmissionPeriodsController do

  let(:admission_period) { create(:admission_period) }
  let(:admission_method) { create(:admission_method) }

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

  context "GET #show" do
    before do
      admission_period.admission_methods<<admission_method
      admission_period.reload
    end
    it 'should be success' do
      gaku_js_get :show_methods, id:admission_period
      response.should be_success
    end

    it 'populates an array of admission methods' do
      gaku_js_get :show_methods, id:admission_period
      assigns(:admission_methods).should eq admission_period.admission_methods
    end

    it 'renders the :show_methods template' do
      gaku_js_get :show_methods, id:admission_period
      response.should render_template :show_methods
    end
  end

  describe 'GET #new' do
    it "assigns a new admission_period to @admission_period" do
      gaku_js_get :new
      assigns(:admission_period).should be_a_new(Gaku::AdmissionPeriod)
    end

    it "renders the :new template" do
      gaku_js_get :new
      response.should render_template :new
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
        expect{
          gaku_js_post :create, admission_period: {name: ''}  
        }.to_not change(Gaku::AdmissionPeriod, :count)
      end
    end
  end

  describe "PUT #update" do

    it "locates the requested @admission_period" do
      gaku_put :update, id: admission_period, admission_period: attributes_for(:admission_period) 
      assigns(:admission_period).should eq(admission_period)
    end

    context "valid attributes" do
      it "changes admission method's attributes" do
        gaku_put :update, id: admission_period,admission_period: attributes_for(:admission_period, name: "Regular Admission")
        admission_period.reload
        admission_period.name.should eq("Regular Admission")

        controller.should set_the_flash
      end
    end

    context "invalid attributes" do
      it "changes admission method's attributes" do
        gaku_js_put :update, id: admission_period,admission_period: attributes_for(:admission_period, name: "")
        admission_period.reload
        admission_period.name.should_not eq("")
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