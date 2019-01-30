require 'spec_helper_models'

describe Gaku::SemesterConnector, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :semester }
    it { is_expected.to belong_to :semesterable }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :semester_id }
    it { is_expected.to validate_presence_of :semesterable_id }
    it { is_expected.to validate_presence_of :semesterable_type }

    it do
      expect(subject).to validate_uniqueness_of(:semester_id).scoped_to(%i[semesterable_id semesterable_type])
      # .with_message(/Semester already added/)
    end

    it { is_expected.to validate_inclusion_of(:semesterable_type).in_array(%w[Gaku::ClassGroup Gaku::Course]) }
  end
end
