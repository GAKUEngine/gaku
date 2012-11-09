require 'spec_helper'

describe Gaku::ExamsController do

  let(:exam) { create(:exam) }

  describe "GET #index" do
    it "is successful" do
      gaku_get :index
      response.should be_success
    end

    pending "populates an array of exams" do
      gaku_get :index
      assigns(:exams).should eq [exam]
    end

    it "renders the :index view" do
      gaku_get :index
      response.should render_template :index
    end
  end 

  describe 'GET #show' do
    it "assigns the requested exam to @exam" do
      gaku_get :show, id: exam
      assigns(:exam).should eq exam
    end

    it "renders the :show template" do
      gaku_get :show, id: exam
      response.should render_template :show
    end
  end

  describe 'GET #new' do
    it "assigns a new exam to @exam" do
      gaku_get :new
      assigns(:exam).should be_a_new(Gaku::Exam)
    end

    it "renders the :new template" do
      gaku_get :new
      response.should render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new exam in the db" do
        expect{
          gaku_post :create, exam: attributes_for(:exam)  
        }.to change(Gaku::Exam, :count).by 1
        
        controller.should set_the_flash
      end
    end
    context "with invalid attributes" do
      it "does not save the new exam in the db" do
        expect{
          gaku_post :create, exam: {name: ''}  
        }.to_not change(Gaku::Exam, :count)
      end
    end
  end

  describe "PUT #update" do

    it "locates the requested @exam" do
      gaku_put :update, id: exam, exam: attributes_for(:exam) 
      assigns(:exam).should eq(exam)
    end

    context "valid attributes" do
      it "changes exam's attributes" do
        gaku_put :update, id: exam,exam: attributes_for(:exam, name: "Math2012Fall")
        exam.reload
        exam.name.should eq("Math2012Fall")

        #TODO controller.should set_the_flash
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the exam" do
      @exam = create(:exam)
      expect{
        gaku_delete :destroy, id: @exam
      }.to change(Gaku::Exam, :count).by -1

      controller.should set_the_flash
    end
  end
end