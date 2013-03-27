require 'spec_helper'

describe Gaku::LessonPlan do

  context "validations" do

    it_behaves_like 'notable'

  	it { should have_many(:lessons) }
  	it { should have_many(:attachments) }
  	it { should belong_to(:syllabus) }

  	it { should allow_mass_assignment_of :title }
  	it { should allow_mass_assignment_of :description }
  end

  context 'counter_cache' do

    let!(:lesson_plan) { FactoryGirl.create(:lesson_plan) }

    context 'notes_count' do

      let(:note) { build(:note) }
      let(:lesson_plan_with_note) { create(:lesson_plan, :with_note) }

      it "increments notes_count" do
        expect do
          lesson_plan.notes << note
        end.to change { lesson_plan.reload.notes_count }.by 1
      end

      it "decrements notes_count" do
        expect do
          lesson_plan_with_note.notes.last.destroy
        end.to change { lesson_plan_with_note.reload.notes_count }.by -1
      end
    end
  end

end
