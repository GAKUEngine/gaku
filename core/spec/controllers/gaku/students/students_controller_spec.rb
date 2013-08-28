require 'spec_helper'

describe Gaku::StudentsController do

  let!(:admin) { create(:admin_user) }
  let!(:enrollment_status) { create(:enrollment_status_admitted) }
  let(:student) { create(:student, enrollment_status_code: enrollment_status.code) }
  let(:valid_attributes) { {name: "Marta", surname: "Kostova"} }
  let(:invalid_attributes) { {name: ""} }

  describe "GET #index" do
    before do
      student
      gaku_get :index
    end

    it { should respond_with 200 }
    it('assigns @students') { expect(assigns(:students)).to eq [student] }
    it('assigns @count') { expect(assigns(:count)).to eq 1 }
    it('assigns @enrollment_statuses') { expect(assigns(:enrollment_statuses)).to_not be_nil }
    it('assigns @countries') { expect(assigns(:countries)).to_not be_nil }
    it('assigns @class_groups') { expect(assigns(:class_groups)).to_not be_nil }
    it('renders :index template') { template? :index }
  end

  describe 'GET #show' do
    before { gaku_get :show, id: student }

    it { should respond_with(:success) }
    it('renders') { should render_template :show }
    it('assigns  @student') { assigns(:student).should eq student }
  end

  describe 'GET #new' do
    before { gaku_js_get :new }

    it { should respond_with 200 }
    it('renders :new template') { template? :new }
    it('assigns @student') { expect(assigns(:student)).to be_a_new(Gaku::Student) }
    it('assigns @class_groups') { expect(assigns(:class_groups)).to_not be_nil }
    it('assigns @enrollment_statuses') { expect(assigns(:enrollment_statuses)).to_not be_nil }
    it('assigns @scholarship_statuses') { expect(assigns(:scholarship_statuses)).to_not be_nil }
    it('assigns @commute_method_types') { expect(assigns(:commute_method_types)).to_not be_nil }
  end

  describe 'GET #edit' do
    before { gaku_js_get :edit, id: student }

    it { should respond_with 200 }
    it('renders :new template') { template? :edit }
    it('assigns @student') { expect(assigns(:student)).to eq student }
    it('assigns @class_groups') { expect(assigns(:class_groups)).to_not be_nil }
    it('assigns @enrollment_statuses') { expect(assigns(:enrollment_statuses)).to_not be_nil }
    it('assigns @scholarship_statuses') { expect(assigns(:scholarship_statuses)).to_not be_nil }
    it('assigns @commute_method_types') { expect(assigns(:commute_method_types)).to_not be_nil }
  end

  describe "POST #create" do

    context "with valid attributes" do
      let(:js_post!) { gaku_js_post :create, student: valid_attributes }

      it "saves" do
        expect { js_post! }.to change(Gaku::Student, :count).by 1
        response.should be_success
        response.should render_template :create
      end
    end

    context "with invalid attributes" do
      let(:js_post!) { gaku_js_post :create, student: invalid_attributes }

      it "does not save" do
        expect{ js_post!}.to_not change(Gaku::Student, :count)
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

        controller.should set_the_flash
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the student" do
      student
      expect{
        gaku_js_delete :destroy, id: student
      }.to change(Gaku::Student, :count).by -1

      #controller.should set_the_flash
    end
  end

end
