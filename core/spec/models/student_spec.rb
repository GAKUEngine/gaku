require 'spec_helper_models'

describe Gaku::Student do

  describe 'concerns' do
    it_behaves_like 'person'
    it_behaves_like 'addressable'
    it_behaves_like 'notable'
    it_behaves_like 'contactable'
    it_behaves_like 'avatarable'
  end

  describe 'associations' do
    it { should have_many(:course_enrollments).dependent(:destroy) }
    it { should have_many(:courses).through(:course_enrollments) }

    it { should have_many :class_group_enrollments }
    it { should have_many(:class_groups).through(:class_group_enrollments) }

    it { should have_many :student_specialties }
    it { should have_many(:specialties).through(:student_specialties) }

    it { should have_many :badges }
    it { should have_many(:badge_types).through(:badges) }

    it { should have_many(:student_guardians).dependent(:destroy) }
    it { should have_many(:guardians).through(:student_guardians) }

    it { should have_many :exam_portion_scores }
    it { should have_many :assignment_scores }
    it { should have_many :attendances }

    it { should have_many :external_school_records }
    it { should have_many :simple_grades }

    it { should belong_to :commute_method_type }
    it { should belong_to :user }
    it { should belong_to :scholarship_status }
    it { should belong_to :enrollment_status }

    it { should accept_nested_attributes_for(:guardians).allow_destroy(true) }

  end

  describe '#set_serial_id' do
    it 'generates serial_id' do
      student = create(:student)
      expect(student.serial_id).to eq("%05d" % student.id)
    end
  end


  describe '#set_code' do

    it "returns '**-****-serial_id' if missing major specialty and admitted" do
      student = create(:student)
      expect(student.code).to eq "**-****-#{student.serial_id}"
    end

    it "returns '**-year-serial_id' if no major specialty but admitted" do
      student = create(:student, admitted: Time.now)
      expect(student.code).to eq "**-#{Time.now.year}-#{student.serial_id}"
    end

    it "returns 'major_specialty-year-serial_id'" do
      student = create(:student, admitted: Time.now)
      expect(student.code).to eq "**-#{Time.now.year}-#{student.serial_id}"
    end
  end


  context 'counter_cache' do

    let!(:student) { create(:student) }

    context 'guardians_count' do

      let(:guardian) { create(:guardian) }
      let(:student_with_one_guardian) { create(:student_with_one_guardian) }

      it 'increments guardians_count' do
        guardian
        expect do
          student.guardians << guardian
          student.reload
        end.to change { student.guardians_count }.by 1
      end

      it 'decrements guardians_count' do
        expect do
          student_with_one_guardian.guardians.last.destroy
        end.to change { student_with_one_guardian.reload.guardians_count }.by -1
      end
    end

     context 'external_school_records_count' do

      let(:school) { create(:school) }
      let(:external_school_record) { create(:external_school_record, school: school, student: student) }

      it 'increments' do
        external_school_record
        expect do
          external_school_record
          student.reload
        end.to change { student.external_school_records_count }.by 1
      end

      it 'decrements' do
        external_school_record
        puts student.external_school_records.last.to_json
        expect do
          student.external_school_records.last.destroy
        end.to change { student.reload.external_school_records_count }.by -1
      end
    end

    context 'courses_count' do

      let(:course) { create(:course) }
      let(:student_with_course) { create(:student, :with_course) }

      it 'increments courses_count' do
        expect do
          student.courses << course
          student.reload
        end.to change { student.courses_count }.by 1
      end

      it 'decrements courses_count' do
        expect do
          student_with_course.courses.last.destroy
        end.to change { student_with_course.reload.courses_count }.by -1
      end
    end

    context 'addresses_count' do

      let(:address) { build(:address) }
      let(:student_with_address) { create(:student, :with_address) }

      it 'increments addresses_count' do
        expect do
          student.addresses << address
        end.to change { student.reload.addresses_count }.by 1
      end

      it 'decrements addresses_count' do
        expect do
          student_with_address.addresses.last.destroy
        end.to change { student_with_address.reload.addresses_count }.by -1
      end
    end

    context 'contacts_count' do

      let(:contact) { build(:contact) }
      let(:student_with_contact) { create(:student, :with_contact) }

      it 'increments contacts_count' do
        expect do
          student.contacts << contact
        end.to change { student.reload.contacts_count }.by 1
      end

      it 'decrements contacts_count' do
        expect do
          student_with_contact.contacts.last.destroy
        end.to change { student_with_contact.reload.contacts_count }.by -1
      end
    end

    context 'notes_count' do

      let(:note) { build(:note) }
      let(:student_with_note) { create(:student, :with_note) }

      it 'increments notes_count' do
        expect do
          student.notes << note
        end.to change { student.reload.notes_count }.by 1
      end

      it 'decrements notes_count' do
        expect do
          student_with_note.notes.last.destroy
        end.to change { student_with_note.reload.notes_count }.by -1
      end
    end

  end

  context 'methods' do
    xit 'scholarship'
    xit 'class_group_widget'
    xit 'seat_number_widget'
    xit 'address_widget'
    xit 'primary_address'
  end

end
