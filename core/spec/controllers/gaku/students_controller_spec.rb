require 'spec_helper'

describe Gaku::StudentsController do

  let(:student) { create(:student) }
  let(:valid_attributes) { {name: "Marta", surname: "Kostova"} }
  let(:invalid_attributes) { {name: ""} }

  describe "GET #index" do
    before { gaku_get :index }

    it { should respond_with(:success) }
    it('assigns @students') { assigns(:students).should eq [student] }
    it('renders') { should render_template :index }
  end

  describe 'GET #show' do
    before { gaku_get :show, id: student }

    it { should respond_with(:success) }
    it('renders') { should render_template :show }
    it('assigns  @student') { assigns(:student).should eq student }
  end

  describe 'GET #new' do
    before { gaku_xhr_get :new }

    it { should respond_with(:success) }
    it('renders') { should render_template :new }
    it('assigns @student') { assigns(:student).should be_a_new(Gaku::Student) }
  end

  describe "POST #create" do

    context "with valid attributes" do
      let(:xhr_post!) { gaku_xhr_post :create, student: valid_attributes }

      it "saves" do
        expect { xhr_post! }.to change(Gaku::Student, :count).by 1
        response.should be_success
        response.should render_template :create
      end
    end

    context "with invalid attributes" do
      let(:xhr_post!) { gaku_xhr_post :create, student: invalid_attributes }

      it "does not save" do
        expect{ xhr_post!}.to_not change(Gaku::Student, :count)
        response.should be_success
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
        gaku_put :update, id: student, student: attributes_for(:student, name: "Kostova Marta")
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
