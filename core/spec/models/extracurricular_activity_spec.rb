require 'spec_helper_models'

describe Gaku::ExtracurricularActivity, type: :model do

  describe 'concerns' do
    it_behaves_like 'enrollable'
  end

  describe 'associations' do
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

  describe '#to_s' do
    let(:extracurricular_activity) { build(:extracurricular_activity) }
    specify { extracurricular_activity.to_s.should eq extracurricular_activity.name }
  end

  context 'counter_cache' do

    let!(:extracurricular_activity) { create(:extracurricular_activity) }

    context 'enrollments_count' do

      let(:student) { build(:student) }
      let(:extracurricular_activity_with_enrollment) { create(:extracurricular_activity, :with_enrollment) }

      it 'increments enrollments_count' do
        expect do
          extracurricular_activity.students << student
        end.to change { extracurricular_activity.reload.enrollments_count }.by(1)
      end

      it 'decrements enrollments_count' do
        expect do
          extracurricular_activity_with_enrollment.students.last.destroy
        end.to change { extracurricular_activity_with_enrollment.reload.enrollments_count }.by(-1)
      end
    end
  end

end
