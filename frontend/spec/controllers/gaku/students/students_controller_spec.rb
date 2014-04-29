require 'spec_helper_controllers'

describe Gaku::StudentsController do

  let!(:admin) { create(:admin_user) }
  let!(:enrollment_status) { create(:enrollment_status_admitted) }
  let(:enrollment_status_not_active) { create(:enrollment_status, active: false) }
  let(:student) { create(:student, enrollment_status_code: enrollment_status.code) }
  let(:valid_attributes) { {name: 'Marta', surname: 'Kostova'} }
  let(:invalid_attributes) { {name: ''} }

  context 'search' do
    describe 'name' do

      let!(:student1) { create(:student, name: 'Rei', surname: 'Kagetsuki', enrollment_status_code: enrollment_status.code, birth_date: Date.new(1950,9,1)) }
      let!(:student2) { create(:student, name: 'Vassil', surname: 'Kalkov', enrollment_status_code: enrollment_status.code, birth_date: Date.new(2013,10,5)) }

      it 'searches by name' do
        gaku_js_get :search, q: { name_cont: 'Re' }

        expect(assigns(:students)).to eq [student1]
        expect(assigns(:students).size).to eq 1
      end

      it 'searches by surname' do
        gaku_js_get :search, q: { surname_cont: 'Kal' }

        expect(assigns(:students)).to eq [student2]
        expect(assigns(:students).size).to eq 1
      end

      it 'searches by birth_date_gteq' do
        gaku_js_get :search, q: { birth_date_gteq: Date.new(2000,1,1) }

        expect(assigns(:students)).to eq [student2]
        expect(assigns(:students).size).to eq 1
      end

      it 'searches by birth_date_lteq' do
        gaku_js_get :search, q: { birth_date_lteq: Date.new(2000,1,1) }

        expect(assigns(:students)).to eq [student1]
        expect(assigns(:students).size).to eq 1
      end

      context 'age' do

        it 'searches by age_gteq' do
          gaku_js_get :search, q: { age_gteq: 50 }

          expect(assigns(:students)).to eq [student1]
          expect(assigns(:students).size).to eq 1
        end

        it 'searches by age_lteq' do
          gaku_js_get :search, q: { age_lteq: 50 }

          expect(assigns(:students)).to eq [student2]
          expect(assigns(:students).size).to eq 1
        end
      end
    end

    describe 'academic' do
      context 'graduated' do

        let!(:student1) { create(:student, name: 'Rei', surname: 'Kagetsuki', graduated: Date.new(1983,9,1)) }
        let!(:student2) { create(:student, name: 'Vassil', surname: 'Kalkov', graduated: Date.new(2000,10,5)) }

        before do
          student1
          student2
        end

        it 'searches by graduated_gteq' do
          gaku_js_get :search, q: { graduated_gteq: Date.new(2000,1,1) }
          expect(assigns(:students)).to eq [student2]
          expect(assigns(:students).size).to eq 1
        end

        it 'searches by graduated_lteq' do
          gaku_js_get :search, q: { graduated_lteq: Date.new(2000,1,1) }

          expect(assigns(:students)).to eq [student1]
          expect(assigns(:students).size).to eq 1
        end
      end

      context 'admitted' do

        let!(:student1) { create(:student, name: 'Rei', surname: 'Kagetsuki', admitted: Date.new(1983,9,1)) }
        let!(:student2) { create(:student, name: 'Vassil', surname: 'Kalkov', admitted: Date.new(2000,10,5)) }

        before do
          student1
          student2
        end

        it 'searches by admitted_gteq' do
          gaku_js_get :search, q: { admitted_gteq: Date.new(2000,1,1) }
          expect(assigns(:students)).to eq [student2]
          expect(assigns(:students).size).to eq 1
        end

        it 'searches by admitted_lteq' do
          gaku_js_get :search, q: { admitted_lteq: Date.new(2000,1,1) }

          expect(assigns(:students)).to eq [student1]
          expect(assigns(:students).size).to eq 1
        end
      end


      context 'specialty' do
        let(:student) { create(:student, name: 'Vassil', surname: 'Kalkov', enrollment_status_code: enrollment_status.code) }
        let(:specialty) { create(:specialty, name: 'Clojure') }
        let(:student_specialty) { create(:student_specialty, student: student, specialty: specialty) }

        it 'searches by specialty' do
          student_specialty
          gaku_js_get :search, q: { specialties_name_cont: 'ju' }

          expect(assigns(:students)).to eq [student]
          expect(assigns(:students).size).to eq 1
        end
      end

    end

    describe 'address' do
      let(:student1) { create(:student, name: 'Rei', surname: 'Kagetsuki', enrollment_status_code: enrollment_status.code) }
      let(:student2) { create(:student, name: 'Vassil', surname: 'Kalkov', enrollment_status_code: enrollment_status.code) }
      let(:country1) { create(:country, name: 'Japan') }
      let(:country2) { create(:country, name: 'Bulgaria') }
      let(:state1) { create(:state, name: 'Aici', country: country1) }
      let(:state2) { create(:state, name: 'Varna', country: country2) }
      let!(:address1) { create(:address, title: 'GTR', address1: 'Toyota str.', address2: 'gt86 str.', city: 'Nagoya', zipcode: '5000', state: state1, country: country1, addressable: student1) }
      let!(:address2) { create(:address, title: 'S2000', address1: 'Subaru str.', address2: 'wrx str.', city: 'Varna', zipcode: '9004', state: state2, country: country2, addressable: student2) }

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

    describe 'setting session' do
      it 'sets session based on params[:q]' do
        gaku_js_get :index, q: { enrollment_status_code_eq: 'admitted' }
        expect(session[:q]['enrollment_status_code_eq']).to eq 'admitted'
      end

      it "doesn't set session if params[:q] is nil" do
        gaku_js_get :index
        expect(session[:q]).to eq nil
      end

      it "changes session if params[:q] is changed" do
        gaku_js_get :index, q: { enrollment_status_code_eq: 'admitted' }
        expect(session[:q]['enrollment_status_code_eq']).to eq 'admitted'
        gaku_js_get :index, q: { enrollment_status_code_eq: 'admitted', graduated_gteq: 'test' }
        expect(session[:q]['enrollment_status_code_eq']).to eq 'admitted'
        expect(session[:q]['graduated_gteq']).to eq 'test'
      end

    end


    describe 'search unscoped' do
      let(:unscoped_student) { create(:student, enrollment_status_code: enrollment_status_not_active.code) }

      it 'searches by enrollment_status_code_eq' do
        unscoped_student
        gaku_js_get :index, q: { enrollment_status_code_eq: '' }
        expect(assigns(:students)).to eq [unscoped_student]
      end

      it 'searches by graduated_gteq' do
        unscoped_student
        gaku_js_get :index, q: { graduated_gteq: '' }
        expect(assigns(:students)).to eq [unscoped_student]
      end

      it 'searches by graduated_lteq' do
        unscoped_student
        gaku_js_get :index, q: { graduated_lteq: '' }
        expect(assigns(:students)).to eq [unscoped_student]
      end

      it 'searches by admitted_gteq' do
        unscoped_student
        gaku_js_get :index, q: { admitted_gteq: '' }
        expect(assigns(:students)).to eq [unscoped_student]
      end

      it 'searches by admitted_lteq' do
        unscoped_student
        gaku_js_get :index, q: { admitted_lteq: '' }
        expect(assigns(:students)).to eq [unscoped_student]
      end
    end


    describe 'search active scope' do
      let(:unscoped_student) { create(:student, enrollment_status_code: enrollment_status_not_active.code) }

      it 'searches by enrollment_status_code_eq' do
        unscoped_student
        gaku_js_get :index, q: { name_eq: '' }
        expect(assigns(:students)).to eq []
      end

    end

     describe 'sorting' do
      context 'by created_at' do
        it 'sorts by created_at' do
          student
          gaku_js_get :index, q: { name_eq: '' }
          expect(assigns(:search).sorts.first.name).to eq 'created_at'
          expect(assigns(:search).sorts.first.dir).to eq 'desc'
        end
      end

      context 'by birth_date' do
        it 'sorts by birth_date when params[:q][:birth_date_gteq] is present' do
          student
          gaku_js_get :index, q: { birth_date_gteq: '2012' }
          expect(assigns(:search).sorts.first.name).to eq 'birth_date'
          expect(assigns(:search).sorts.first.dir).to eq 'desc'
        end

        it 'sorts by birth_date when params[:q][:birth_date_lteq] is present' do
          student
          gaku_js_get :index, q: { birth_date_lteq: '2012' }
          expect(assigns(:search).sorts.first.name).to eq 'birth_date'
          expect(assigns(:search).sorts.first.dir).to eq 'desc'
        end

        it 'sorts by birth_date when params[:q][:age_gteq] is present' do
          student
          gaku_js_get :index, q: { age_gteq: '2012' }
          expect(assigns(:search).sorts.first.name).to eq 'birth_date'
          expect(assigns(:search).sorts.first.dir).to eq 'desc'
        end

        it 'sorts by birth_date when params[:q][:age_lteq] is present' do
          student
          gaku_js_get :index, q: { age_lteq: '2012' }
          expect(assigns(:search).sorts.first.name).to eq 'birth_date'
          expect(assigns(:search).sorts.first.dir).to eq 'desc'
        end
      end

    end

  end

  context 'HTML' do
    describe 'GET #index' do
      let(:preset) { create(:preset) }

      before do
        student; preset
        gaku_get :index
      end

      it { should respond_with 200 }
      it('assigns @students') { expect(assigns(:students)).to eq [student] }
      it('assigns @count') { expect(assigns(:count)).to eq 1 }
      it('assigns @preset') { expect(assigns(:preset)).to_not be_nil }
      it('renders :index template') { template? :index }
    end

    describe 'GET #show' do
      before { gaku_get :show, id: student }

      it { should respond_with(:success) }
      it('renders') { should render_template :show }
      it('assigns  @student') { assigns(:student).should eq student }
    end

    describe 'GET #new' do
      before { gaku_get :new }

      it { should respond_with 200 }
      it('renders :new template') { template? :new }
      it('assigns @student') { expect(assigns(:student)).to be_a_new(Gaku::Student) }
      it('assigns @class_groups') { expect(assigns(:class_groups)).to_not be_nil }
      it('assigns @enrollment_statuses') { expect(assigns(:enrollment_statuses)).to_not be_nil }
      it('assigns @scholarship_statuses') { expect(assigns(:scholarship_statuses)).to_not be_nil }
      it('assigns @commute_method_types') { expect(assigns(:commute_method_types)).to_not be_nil }
    end

    describe 'POST #create' do

      context 'with valid attributes' do
        let(:html_post) { gaku_post :create, student: valid_attributes }

        it 'saves' do
          expect { html_post }.to change(Gaku::Student, :count).by(1)
        end

        it 'redirects' do
          html_post
          redirect_to? "/students/#{Gaku::Student.last.id}/edit"
          expect(response.code).to eq '302'
        end
      end

      context 'with invalid attributes' do
        let(:html_post) { gaku_post :create, student: invalid_attributes }

        it 'does not save' do
          expect{ html_post }.to_not change(Gaku::Student, :count).by(1)
        end

        it 'renders :new template' do
          html_post
          template? :new
        end
      end
    end

    describe 'GET #edit' do
      before { gaku_get :edit, id: student }

      it { should respond_with 200 }
      it('renders :new template') { template? :edit }
      it('assigns @student') { expect(assigns(:student)).to eq student }
      it('assigns @class_groups') { expect(assigns(:class_groups)).to_not be_nil }
      it('assigns @enrollment_statuses') { expect(assigns(:enrollment_statuses)).to_not be_nil }
      it('assigns @scholarship_statuses') { expect(assigns(:scholarship_statuses)).to_not be_nil }
      it('assigns @commute_method_types') { expect(assigns(:commute_method_types)).to_not be_nil }
    end

    describe 'PATCH #update' do

      it 'locates the requested @student' do
        gaku_patch :update, id: student, student: attributes_for(:student)
        assigns(:student).should eq(student)
      end

      context 'valid attributes' do
        it "changes student's attributes" do
          gaku_patch :update, id: student, student: attributes_for(:student, name: 'Kostova Marta')
          student.reload
          student.name.should eq('Kostova Marta')

          controller.should set_the_flash
        end
      end
    end

  end

  context 'JS' do

    describe 'JS GET #chosen' do
      before do
        student
        gaku_js_get :chosen
      end

      it { should respond_with 200 }
      it('renders :chosen template') { template? :chosen }
    end

    describe 'JS GET #advanced_search' do
      before do
        student
        gaku_js_get :advanced_search
      end

      it { should respond_with 200 }
      it('assigns @students') { expect(assigns(:students)).to eq [student] }
      it('assigns @countries') { expect(assigns(:countries)).to_not be_nil }
      it('assigns @enrollment_statuses') { expect(assigns(:enrollment_statuses)).to_not be_nil }
      it('renders :advanced_search template') { template? :advanced_search }
    end

    describe 'JS GET #new' do
      before { gaku_js_get :new }

      it { should respond_with 200 }
      it('renders :new template') { template? :new }
      it('assigns @student') { expect(assigns(:student)).to be_a_new(Gaku::Student) }
      it('assigns @class_groups') { expect(assigns(:class_groups)).to_not be_nil }
      it('assigns @enrollment_statuses') { expect(assigns(:enrollment_statuses)).to_not be_nil }
      it('assigns @scholarship_statuses') { expect(assigns(:scholarship_statuses)).to_not be_nil }
      it('assigns @commute_method_types') { expect(assigns(:commute_method_types)).to_not be_nil }
    end

    describe 'DELETE #destroy' do
      it 'deletes the student' do
        student
        expect do
          gaku_js_delete :destroy, id: student
        end.to change(Gaku::Student, :count).by -1
      end
    end

  end

end
