require 'spec_helper_controllers'

describe Gaku::Admin::DisposalsController do

  before { as :admin }

  describe 'GET #index' do
    before { gaku_get :index }

    it { should respond_with 200 }
    it('renders :index template') { template? :index }
  end

  describe 'GET #exams' do
    let(:deleted_exam) { create(:exam, deleted: true) }
    let(:exam) { create(:exam, deleted: false) }

    before do
      exam
      deleted_exam
      gaku_get :exams
    end

    it { should respond_with 200 }
    it('assigns @exams') { expect(assigns(:exams)).to eq [deleted_exam] }
    it('renders :exams template') { template? :exams }
  end

  describe 'GET #course_groups' do
    let(:deleted_course_group) { create(:course_group, deleted: true) }
    let(:course_group) { create(:course_group, deleted: false) }

    before do
      course_group
      deleted_course_group
      gaku_get :course_groups
    end

    it { should respond_with 200 }
    it('assigns @course_groups') { expect(assigns(:course_groups)).to eq [deleted_course_group] }
    it('renders :course_groups template') { template? :course_groups }
  end

  describe 'GET #attachments' do
    let(:deleted_attachment) { create(:attachment, deleted: true) }
    let(:attachment) { create(:attachment, deleted: false) }

    before do
      attachment
      deleted_attachment
      gaku_get :attachments
    end

    it { should respond_with 200 }
    it('assigns @attachments') { expect(assigns(:attachments)).to eq [deleted_attachment] }
    it('renders :attachments template') { template? :attachments }
  end

  describe 'GET #students' do
    let(:deleted_student) { create(:student, deleted: true) }
    let(:student) { create(:student, deleted: false) }

    before do
      student
      deleted_student
      gaku_get :students
    end

    it { should respond_with 200 }
    it('assigns @students') { expect(assigns(:students)).to eq [deleted_student] }
    it('renders :students template') { template? :students }
  end

  describe 'GET #teachers' do
    let(:deleted_teacher) { create(:teacher, deleted: true) }
    let(:teacher) { create(:teacher, deleted: false) }

    before do
      teacher
      deleted_teacher
      gaku_get :teachers
    end

    it { should respond_with 200 }
    it('assigns @teachers') { expect(assigns(:teachers)).to eq [deleted_teacher] }
    it('renders :teachers template') { template? :teachers }
  end

  describe 'GET #guardians' do
    let(:deleted_guardian) { create(:guardian, deleted: true) }
    let(:guardian) { create(:guardian, deleted: false) }

    before do
      guardian
      deleted_guardian
      gaku_get :guardians
    end

    it { should respond_with 200 }
    it('assigns @guardians') { expect(assigns(:guardians)).to eq [deleted_guardian] }
    it('renders :guardians template') { template? :guardians }
  end

  describe 'GET #addresses' do
    context 'student_addresses' do
      let(:student) { create(:student) }
      let(:deleted_address) { create(:address, addressable: student, deleted: true) }
      let(:address) { create(:address, addressable: student, deleted: false) }

      before do
        address
        deleted_address
        gaku_get :addresses
      end

      it { should respond_with 200 }
      it('assigns @student_addresses') { expect(assigns(:student_addresses)).to eq [deleted_address] }
      it('assigns @students_count') { expect(assigns(:students_count)).to eq 1 }
      it('renders :addresses template') { template? :addresses }
    end

    context 'teacher_addresses' do
      let(:teacher) { create(:teacher) }
      let(:deleted_address) { create(:address, addressable: teacher, deleted: true) }
      let(:address) { create(:address, addressable: teacher, deleted: false) }

      before do
        address
        deleted_address
        gaku_get :addresses
      end

      it { should respond_with 200 }
      it('assigns @teacher_addresses') { expect(assigns(:teacher_addresses)).to eq [deleted_address] }
      it('assigns @teachers_count') { expect(assigns(:teachers_count)).to eq 1 }
      it('renders :addresses template') { template? :addresses }
    end
  end

  describe 'GET #contacts' do
    context 'student_contacts' do
      let(:student) { create(:student) }
      let(:deleted_contact) { create(:contact, contactable: student, deleted: true) }
      let(:contact) { create(:contact, contactable: student, deleted: false) }

      before do
        contact
        deleted_contact
        gaku_get :contacts
      end

      it { should respond_with 200 }
      it('assigns @student_contacts') { expect(assigns(:student_contacts)).to eq [deleted_contact] }
      it('assigns @students_count') { expect(assigns(:students_count)).to eq 1 }
      it('renders :contacts template') { template? :contacts }
    end

    context 'teacher_contacts' do
      let(:teacher) { create(:teacher) }
      let(:deleted_contact) { create(:contact, contactable: teacher, deleted: true) }
      let(:contact) { create(:contact, contactable: teacher, deleted: false) }

      before do
        contact
        deleted_contact
        gaku_get :contacts
      end

      it { should respond_with 200 }
      it('assigns @teacher_contacts') { expect(assigns(:teacher_contacts)).to eq [deleted_contact] }
      it('assigns @teachers_count') { expect(assigns(:teachers_count)).to eq 1 }
      it('renders :contacts template') { template? :contacts }
    end
  end

end
