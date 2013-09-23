require 'spec_helper'

describe Gaku::StudentsController do

  let!(:admin) { create(:admin_user) }
  let!(:enrollment_status) { create(:enrollment_status_admitted) }
  let(:student) { create(:student, enrollment_status_code: enrollment_status.code) }
  let(:valid_attributes) { {name: "Marta", surname: "Kostova"} }
  let(:invalid_attributes) { {name: ""} }

  context 'search' do
    describe 'name' do

      let(:student1) { create(:student, name: 'Rei', surname: 'Kagetsuki', enrollment_status_code: enrollment_status.code, birth_date: Date.new(1983,9,1)) }
      let(:student2) { create(:student, name: 'Vassil', surname: 'Kalkov', enrollment_status_code: enrollment_status.code, birth_date: Date.new(1983,10,5)) }

      it 'searches by name' do
        gaku_js_get :index, q: { name_cont: "Re" }
        puts assigns(:students).to_json
        expect(assigns(:students)).to eq [student1]
        expect(assigns(:students).size).to eq 1
      end

      it 'searches by surname' do
        gaku_js_get :index, q: { surname_cont: "Kal" }

        expect(assigns(:students)).to eq [student2]
        expect(assigns(:students).size).to eq 1
      end

      xit 'searches by birth_date from begining' do
        gaku_js_get :index, q: { birth_date_gteq: Date.new(1980,1,1) }

        expect(assigns(:students)).to eq [student2]
        expect(assigns(:students).size).to eq 1
      end
    end

    describe 'address' do
      let(:student1) { create(:student, name: 'Rei', surname: 'Kagetsuki', enrollment_status_code: enrollment_status.code) }
      let(:student2) { create(:student, name: 'Vassil', surname: 'Kalkov', enrollment_status_code: enrollment_status.code) }
      let(:country1) { create(:country, name: 'Japan') }
      let(:country2) { create(:country, name: 'Bulgaria') }
      let(:state1) { create(:state, name: "Aici", country: country1) }
      let(:state2) { create(:state, name: "Varna", country: country2) }
      let!(:address1) { create(:address, title: 'GTR', address1: "Toyota str.", address2: "gt86 str.", city: 'Nagoya', zipcode: '5000', state: state1, country: country1, addressable: student1) }
      let!(:address2) { create(:address, title: 'S2000', address1: "Subaru str.", address2: "wrx str.", city: 'Varna', zipcode: '9004', state: state2, country: country2, addressable: student2) }

      before do
        student1.addresses.reload
        student2.addresses.reload
      end

      it 'searches by address1' do
        gaku_js_get :index, q: { addresses_address1_cont: 'su' }
        expect(assigns(:students)).to eq [student2]
        expect(assigns(:students).size).to eq 1
      end

      it 'searches by address2' do
        gaku_js_get :index, q: { addresses_address2_cont: 'wrx' }
        expect(assigns(:students)).to eq [student2]
        expect(assigns(:students).size).to eq 1
      end

      it 'searches by city' do
        gaku_js_get :index, q: { addresses_city_cont: 'va' }
        expect(assigns(:students)).to eq [student2]
        expect(assigns(:students).size).to eq 1
      end

      it 'searches by state' do
        gaku_js_get :index, q: { addresses_state_name_cont: 'va' }
        expect(assigns(:students)).to eq [student2]
        expect(assigns(:students).size).to eq 1
      end

      it 'searches by country' do
        gaku_js_get :index, q: { addresses_country_name_eq: country2.name }
        expect(assigns(:students)).to eq [student2]
        expect(assigns(:students).size).to eq 1
      end

      it 'searches by title' do
        gaku_js_get :index, q: { addresses_title_cont: 'S2000' }
        expect(assigns(:students)).to eq [student2]
        expect(assigns(:students).size).to eq 1
      end

      it 'searches by zipcode' do
        gaku_js_get :index, q: { addresses_zipcode_cont: '9' }
        expect(assigns(:students)).to eq [student2]
        expect(assigns(:students).size).to eq 1
      end
    end

  end

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

  describe 'GET #soft_delete' do
    let(:get_soft_delete) { gaku_get :soft_delete, id: student }

    it 'redirects' do
      get_soft_delete
      should respond_with(302)
    end

    it 'assigns  @student' do
      get_soft_delete
      expect(assigns(:student)).to eq student
    end

    it 'updates :deleted attribute' do
      expect do
        get_soft_delete
        student.reload
      end.to change(student, :deleted)
    end
  end

  describe 'GET #recovery' do
    let(:get_recovery) { gaku_js_get :recovery, id: student }

    it 'is successfull' do
      get_recovery
      should respond_with(200)
    end

    it 'assigns  @student' do
      get_recovery
      expect(assigns(:student)).to eq student
    end

    it 'renders :recovery' do
      get_recovery
      should render_template :recovery
   end

    it 'updates :deleted attribute' do
      student.soft_delete
      expect do
        get_recovery
        student.reload
      end.to change(student, :deleted)
    end
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
