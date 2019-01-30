require 'spec_helper_models'

describe Gaku::Badge, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :badge_type }
    it { is_expected.to belong_to :student }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :student_id }
    it { is_expected.to validate_presence_of :badge_type_id }
  end
end
