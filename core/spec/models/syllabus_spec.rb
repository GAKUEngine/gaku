require 'spec_helper'

describe Gaku::Syllabus do

  context "validations" do

    it_behaves_like 'notable'

    it { should have_many :courses }
    it { should have_many :assignments }
    it { should have_many :lesson_plans }
    it { should have_many :notes }
    it { should have_many :programs }

    it { should have_many :exam_syllabuses }
    it { should have_many(:exams).through(:exam_syllabuses) }

    it { should validate_presence_of :name }
    it { should validate_presence_of :code }

    it { should accept_nested_attributes_for :exams }
    it { should accept_nested_attributes_for :assignments }

    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :code }
    it { should allow_mass_assignment_of :description }
    it { should allow_mass_assignment_of :credits }
    it { should allow_mass_assignment_of :exams }
    it { should allow_mass_assignment_of :exams_attributes }
    it { should allow_mass_assignment_of :assignments }
    it { should allow_mass_assignment_of :assignments_attributes }

  end


  context 'counter_cache' do

    let!(:syllabus) { FactoryGirl.create(:syllabus) }

    context 'notes_count' do

      let(:note) { build(:note) }
      let(:syllabus_with_note) { create(:syllabus, :with_note) }

      it "increments notes_count" do
        expect do
          syllabus.notes << note
        end.to change { syllabus.reload.notes_count }.by 1
      end

      it "decrements notes_count" do
        expect do
          syllabus_with_note.notes.last.destroy
        end.to change { syllabus_with_note.reload.notes_count }.by -1
      end
    end

    context 'exams_count' do

      let(:exam) { build(:exam) }
      let(:syllabus_with_exam) { create(:syllabus, :with_exam) }

      it "increments exams_count" do
        expect do
          syllabus.exams << exam
        end.to change { syllabus.reload.exams_count }.by 1
      end

      it "decrements exams_count" do
        expect do
          syllabus_with_exam.exams.last.destroy
        end.to change { syllabus_with_exam.reload.exams_count }.by -1
      end
    end

  end

end
