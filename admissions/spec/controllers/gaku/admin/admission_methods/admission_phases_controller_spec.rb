require 'spec_helper'

describe Gaku::Admin::AdmissionMethods::AdmissionPhasesController do

  let(:admission_method) { create(:admission_method_without_phases) }
  let(:admission_phase) { create(:admission_phase, admission_method: admission_method) }

  describe 'GET #new' do
    it "assigns a new admission_phase to @admission_phase" do
      gaku_js_get :new, admission_method_id: admission_method.id
      assigns(:admission_phase).should be_a_new(Gaku::AdmissionPhase)
    end

    it "renders the :new template" do
        gaku_js_get :new, admission_method_id: admission_method.id
        response.should render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new admission method phase in the db" do
        expect{
          gaku_post :create, admission_method_id: admission_method.id, admission_phase: attributes_for(:admission_phase)  
        }.to change(Gaku::AdmissionPhase, :count).by 1
        
      end
    end
    context "with invalid attributes" do
      it "does not save the new admission method phase in the db" do
          expect{
            gaku_js_post :create, admission_method_id: admission_method.id, admission_phase: {name: ''}  
          }.to_not change(Gaku::AdmissionPhase, :count)
      end
    end
  end

  describe 'GET #edit' do
    it "locates the requested admission_phase" do
      gaku_js_get :edit, id: admission_phase, admission_method_id: admission_method.id
      assigns(:admission_phase).should eq(admission_phase)
    end

    it "renders the :edit template" do
        gaku_js_get :edit, id: admission_phase, admission_method_id: admission_method.id
        response.should render_template :edit
    end
  end

  describe "PUT #update" do
    it "locates the requested @admission_phase" do
      gaku_put :update, id: admission_phase, 
                        admission_phase: attributes_for(:admission_phase), 
                        admission_method_id: admission_method.id
      assigns(:admission_phase).should eq(admission_phase)
    end

    context "valid attributes" do
      it "changes admission phase's attributes" do
        gaku_put :update, id: admission_phase,
                          admission_phase: attributes_for(:admission_phase, name: "Exam"), 
                          admission_method_id: admission_method.id
        admission_phase.reload
        admission_phase.name.should eq("Exam")

        controller.should set_the_flash
      end
    end

    context "invalid attributes" do
      it "does not change admission phase's attributes" do
        gaku_js_put :update, id: admission_phase, 
                              admission_phase: attributes_for(:admission_phase, name: ""),
                              admission_method_id: admission_method.id
        admission_method.reload
        admission_method.name.should_not eq("")
      end
    end
  end

  describe 'GET #show states' do
    it "locates the requested admission_phase's states" do
      gaku_js_get :show_phase_states, id: admission_phase, admission_method_id: admission_method.id
      assigns(:admission_phase).should eq(admission_phase)
    end

    it "renders the :admission_phase_states_modal template" do
      gaku_js_get :show_phase_states, id: admission_phase, admission_method_id: admission_method.id
      response.should render_template :show_phase_states
    end
  end

  describe "DELETE #destroy" do
    it "deletes the admission method_phase" do
      admission_phase
      expect{
        gaku_delete :destroy, id: admission_phase, admission_method_id: admission_method.id
      }.to change(Gaku::AdmissionPhase, :count).by -1

      controller.should set_the_flash
    end
  end

end