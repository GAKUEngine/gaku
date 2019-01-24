require 'spec_helper_models'

describe Gaku::StudentSpecialty, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :specialty }
    it { is_expected.to belong_to :student }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :student_id }
    it { is_expected.to validate_presence_of :specialty_id }
    it { is_expected.to validate_uniqueness_of(:student_id).scoped_to(:specialty_id).with_message(/Specialty already added!/) }
  end
end
