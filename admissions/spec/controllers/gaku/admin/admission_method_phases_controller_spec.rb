require 'spec_helper'

describe Gaku::Admin::AdmissionMethods::AdmissionPhasesController do

  let(:admission_method) { create(:admission_method) }
  let(:admission_phase) { create(:admission_phase) }

=begin  
  before do
    admission_method.admission_phases << admission_phase
    @admission_method = admission_method
  end

  describe "GET #index" do
    it "is successful" do
      gaku_get :index
      response.should be_success
    end

    it "populates an array of admission_method_phases" do
      gaku_get :index
      assigns(:admission_method_phases).should eq [admission_method_phase]
    end

    it "renders the :index view" do
      gaku_get :index
      response.should render_template :index
    end
  end

    describe 'GET #show' do
    it "assigns the requested admission_method_phase to @admission_method_phase" do
      gaku_get :show, id: admission_method_phase
      assigns(:admission_method_phase).should eq admission_method_phase
    end

    it "renders the :show template" do
      gaku_get :show, id: admission_method_phase
      response.should render_template :show
    end
  end

  describe 'GET #new' do
    it "assigns a new admission_method_phase to @admission_method_phase" do
      gaku_xhr_get :new
      assigns(:admission_method_phase).should be_a_new(Gaku::AdmissionMethodPhase)
    end

    it "renders the :new template" do
      #pending "need to resolve why is not rendering :new or remove test" do
        gaku_xhr_get :new
        response.should render_template :new
      #end
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new admission method phase in the db" do
        expect{
          gaku_post :create, admission_method_phase: attributes_for(:admission_method_phase)  
        }.to change(Gaku::AdmissionMethodPhase, :count).by 1
        
        controller.should set_the_flash
      end
    end
    context "with invalid attributes" do
      it "does not save the new admission method phase in the db" do
        pending "need to make validations in model" do
          expect{
            gaku_post :create, admission_method_phase: {name: ''}  
          }.to_not change(Gaku::AdmissionMethodPhase, :count)
        end
      end
    end
  end

  describe "PUT #update" do

    it "locates the requested @admission_method_phase" do
      gaku_put :update, id: admission_method_phase, admission_method_phase: attributes_for(:admission_method_phase) 
      assigns(:admission_method_phase).should eq(admission_method_phase)
    end

    context "valid attributes" do
      it "changes admission metod's attributes" do
        gaku_put :update, id: admission_method_phase,admission_method_phase: attributes_for(:admission_method_phase, name: "AZ")
        admission_method_phase.reload
        admission_method_phase.name.should eq("AZ")

        controller.should set_the_flash
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the admission method_phase" do
      @admission_method_phase = create(:admission_method_phase)
      expect{
        gaku_delete :destroy, id: @admission_method_phase
      }.to change(Gaku::AdmissionMethodPhase, :count).by -1

      controller.should set_the_flash
    end
  end
=end

end