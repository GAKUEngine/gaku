require 'spec_helper'

describe Gaku::StudentsController do

  let(:student) { create(:student) }
  let(:country) { create(:country) }

  describe "GET #index" do
    it "is successful" do
      gaku_get :index
      response.should be_success
    end

    it "populates an array of students" do
      gaku_get :index
      assigns(:students).should eq [student]
    end

    it "renders the :index view" do
      gaku_get :index
      response.should render_template :index
    end
  end 

  describe 'GET #show' do
    it "assigns the requested student to @student" do
      gaku_get :show, id: student
      assigns(:student).should eq student
    end

    it "renders the :show template" do
      gaku_get :show, id: student
      response.should render_template :show
    end
  end

  describe 'GET #new' do
    it "assigns a new student to @student" do
      gaku_get :new
      assigns(:student).should be_a_new(Gaku::Student)
    end

    it "renders the :new template" do
      gaku_get :new
      response.should render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new student in the db" do
        expect{
          gaku_post :create, student: attributes_for(:student)  
        }.to change(Gaku::Student, :count).by 1
        
        controller.should set_the_flash
      end
    end
    context "with invalid attributes" do
      it "does not save the new student in the db" do
        expect{
          gaku_post :create, student: {name: ''}  
        }.to_not change(Gaku::Student, :count)
      end
    end
  end

  describe "PUT #update" do

    it "locates the requested @student" do
      gaku_put :update, id: student, student: attributes_for(:student) 
      assigns(:student).should eq(student)
    end

    context "valid attributes" do
      it "changes student's attributes" do
        gaku_put :update, id: student,student: attributes_for(:student, name: "Kostova Marta")
        student.reload
        student.name.should eq("Kostova Marta")

        #TODO controller.should set_the_flash 
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the student" do
      @student = create(:student)
      expect{
        gaku_delete :destroy, id: @student
      }.to change(Gaku::Student, :count).by -1

      controller.should set_the_flash
    end
  end

end