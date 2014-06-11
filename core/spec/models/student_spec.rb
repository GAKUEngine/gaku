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
    it { should have_many(:enrollments).dependent(:destroy) }
    it { should have_many(:courses).through(:enrollments).source(:enrollmentable)  }
    it { should have_many(:class_groups).through(:enrollments).source(:enrollmentable)  }
    it { should have_many(:extracurricular_activities).through(:enrollments).source(:enrollmentable)  }

    it do
      should have_many(:course_enrollments)
              .class_name('Gaku::Enrollment')
              .conditions(enrollmentable_type: 'Gaku::Course')
    end

    it do
      should have_many(:class_group_enrollments)
              .class_name('Gaku::Enrollment')
              .conditions(enrollmentable_type: 'Gaku::ClassGroup')
    end

    it do
      should have_many(:extracurricular_activity_enrollments)
              .class_name('Gaku::Enrollment')
              .conditions(enrollmentable_type: 'Gaku::ExtracurricularActivity')
    end


    it { should have_many :student_specialties }
    it { should have_many(:specialties).through(:student_specialties) }

    it { should have_many :badges }
    it { should have_many(:badge_types).through(:badges) }

    it { should have_many(:student_guardians).dependent(:destroy) }
    it { should have_many(:guardians).through(:student_guardians) }

    it { should have_many(:student_exam_sessions) }
    it { should have_many(:exam_sessions).through(:student_exam_sessions) }

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

  describe '#primary_contact' do
    it('responds to primary_contact') { should respond_to(:primary_contact) }
  end

  describe 'address' do
    it('responds to primary_address') { should respond_to(:primary_address) }

    it 'generates address_widget' do
      student = build(:student)
      address = create(:address, addressable: student, primary: true)
      expect(student.address_widget).to eq "#{address.city}, #{address.address1}"
    end
  end

  describe '#set_serial_id' do
    it 'generates serial_id' do
      student = create(:student)
      expect(student.serial_id).to eq(format('%05d', student.id))
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

    context 'badges_count' do

      let(:badge) { create(:badge) }
      let(:student_badge) { create(:badge, student: student) }

      xit 'increments' do
        badge
        expect do
          student.badges << badge
          student.reload
          puts student.badges.to_json
        end.to change { student.badges_count }.by(1)
      end

      xit 'decrements' do
        student.badges << student_badge
        expect do
          student.badges.last.destroy!
          student.reload
        end.to change { student.badges_count }.by(-1)
      end
    end

    context 'guardians_count' do

      let(:guardian) { create(:guardian) }
      let(:student_with_one_guardian) { create(:student_with_one_guardian) }

      it 'increments guardians_count' do
        guardian
        expect do
          student.guardians << guardian
          student.reload
        end.to change { student.guardians_count }.by(1)
      end

      it 'decrements guardians_count' do
        expect do
          student_with_one_guardian.guardians.last.destroy
        end.to change { student_with_one_guardian.reload.guardians_count }.by(-1)
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
        end.to change { student.external_school_records_count }.by(1)
      end

      it 'decrements' do
        external_school_record
        expect do
          student.external_school_records.last.destroy
        end.to change { student.reload.external_school_records_count }.by(-1)
      end
    end

    context 'courses_count' do

      let(:course) { create(:course) }
      let(:student_with_course) { create(:student, :with_course) }

      it 'increments courses_count' do
        expect do
          student.courses << course
          student.reload
        end.to change { student.courses_count }.by(1)
      end

      it 'decrements courses_count' do
        expect do
          student_with_course.courses.last.destroy
        end.to change { student_with_course.reload.courses_count }.by(-1)
      end
    end

    context 'class_groups_count' do

      let(:class_group) { create(:class_group) }
      let(:student_with_class_group) { create(:student, :with_class_group) }

      it 'increments class_groups_count' do
        expect do
          student.class_groups << class_group
          student.reload
        end.to change { student.class_groups_count }.by(1)
      end

      it 'decrements class_groups_count' do
        expect do
          student_with_class_group.class_groups.last.destroy
        end.to change { student_with_class_group.reload.class_groups_count }.by(-1)
      end
    end

    context 'extracurricular_activities_count' do

      let(:extracurricular_activity) { create(:extracurricular_activity) }
      let(:student_with_with_extracurricular_activity) { create(:student, :with_extracurricular_activity) }

      it 'increments class_groups_count' do
        expect do
          student.extracurricular_activities << extracurricular_activity
          student.reload
        end.to change { student.extracurricular_activities_count }.by(1)
      end

      it 'decrements extracurricular_activities_count' do
        expect do
          student_with_with_extracurricular_activity.extracurricular_activities.last.destroy
        end.to change { student_with_with_extracurricular_activity.reload.extracurricular_activities_count }.by(-1)
      end
    end

    context 'addresses_count' do

      let(:address) { build(:address) }
      let(:student_with_address) { create(:student, :with_address) }

      it 'increments addresses_count' do
        expect do
          student.addresses << address
        end.to change { student.reload.addresses_count }.by(1)
      end

      it 'decrements addresses_count' do
        expect do
          student_with_address.addresses.last.destroy
        end.to change { student_with_address.reload.addresses_count }.by(-1)
      end
    end

    context 'contacts_count' do

      let(:contact) { build(:contact) }
      let(:student_with_contact) { create(:student, :with_contact) }

      it 'increments contacts_count' do
        expect do
          student.contacts << contact
        end.to change { student.reload.contacts_count }.by(1)
      end

      it 'decrements contacts_count' do
        expect do
          student_with_contact.contacts.last.destroy
        end.to change { student_with_contact.reload.contacts_count }.by(-1)
      end
    end

    context 'notes_count' do

      let(:note) { build(:note) }
      let(:student_with_note) { create(:student, :with_note) }

      it 'increments notes_count' do
        expect do
          student.notes << note
        end.to change { student.reload.notes_count }.by(1)
      end

      it 'decrements notes_count' do
        expect do
          student_with_note.notes.last.destroy
        end.to change { student_with_note.reload.notes_count }.by(-1)
      end
    end

  end
end
