require 'spec_helper'

describe Gaku::Student do

  context "validations" do

    it_behaves_like 'person'
    it_behaves_like 'addressable'
    it_behaves_like 'notable'
    it_behaves_like 'contactable'
    it_behaves_like 'avatarable'
    it_behaves_like 'thrashable'

    it { should have_many :course_enrollments }
    it { should have_many(:courses).through(:course_enrollments) }

    it { should have_many :class_group_enrollments }
    it { should have_many(:class_groups).through(:class_group_enrollments) }

    it { should have_many :student_specialties }
    it { should have_many(:specialties).through(:student_specialties) }

    it { should have_many :achievements }
    it { should have_many(:achievements).through(:student_achievements) }

    it { should have_many :student_guardians}
    it { should have_many(:guardians).through(:student_guardians) }

    it { should have_many :exam_portion_scores }
    it { should have_many :assignment_scores }
    it { should have_many :attendances }
    it { should have_many :achievements }
    it { should have_many :external_school_records }
    it { should have_many :simple_grades }

    it { should belong_to :commute_method_type }
    it { should belong_to :user }
    it { should belong_to :scholarship_status }
    it { should belong_to :enrollment_status }

    it { should accept_nested_attributes_for(:guardians).allow_destroy(true) }

    it { should allow_mass_assignment_of :admitted }
    it { should allow_mass_assignment_of :graduated }
    it { should allow_mass_assignment_of :class_groups }
    it { should allow_mass_assignment_of :class_group_ids }
    it { should allow_mass_assignment_of :class_groups_attributes }
    it { should allow_mass_assignment_of :guardians }
    it { should allow_mass_assignment_of :guardians_attributes }
    it { should allow_mass_assignment_of :student_id_number }
    it { should allow_mass_assignment_of :student_foreign_id_number }
    it { should allow_mass_assignment_of :scholarship_status_id }
    it { should allow_mass_assignment_of :enrollment_status_id }
  end

  context 'counter_cache' do

    let!(:student) { FactoryGirl.create(:student) }


    context 'guardians_count' do

      let(:guardian) { create(:guardian) }
      let(:student_with_one_guardian) { create(:student_with_one_guardian) }

      it "increments guardians_count" do
        expect do
          student.guardians << guardian
        end.to change { student.guardians_count }.by 1
      end

      it "decrements guardians_count" do
        expect do
          student_with_one_guardian.guardians.last.destroy
        end.to change { student_with_one_guardian.reload.guardians_count }.by -1
      end
    end

    context 'addresses_count' do

      let(:address) { build(:address) }
      let(:student_with_one_address) { create(:student_with_one_address) }

      it "increments addresses_count" do
        expect do
          student.addresses << address
        end.to change { student.reload.addresses_count }.by 1
      end

      it "decrements addresses_count" do
        expect do
          student_with_one_address.addresses.last.destroy
        end.to change { student_with_one_address.reload.addresses_count }.by -1
      end
    end

    context 'contacts_count' do

      let(:contact) { build(:contact) }
      let(:student_with_one_contact) { create(:student_with_one_contact) }

      it "increments contacts_count" do
        expect do
          student.contacts << contact
        end.to change { student.reload.contacts_count }.by 1
      end

      it "decrements contacts_count" do
        expect do
          student_with_one_contact.contacts.last.destroy
        end.to change { student_with_one_contact.reload.contacts_count }.by -1
      end
    end


    context 'notes_count' do

      let(:note) { build(:note) }
      let(:student_with_one_note) { create(:student_with_one_note) }

      it "increments notes_count" do
        expect do
          student.notes << note
        end.to change { student.reload.notes_count }.by 1
      end

      it "decrements notes_count" do
        expect do
          student_with_one_note.notes.last.destroy
        end.to change { student_with_one_note.reload.notes_count }.by -1
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
