require 'spec_helper_models'

describe Gaku::School, type: :model do
  describe 'concerns' do
    it_behaves_like 'avatarable'
  end

  describe 'associations' do
    it { is_expected.to have_many :levels }
    it { is_expected.to have_many :campuses }
    it { is_expected.to have_many :simple_grade_types }
    it { is_expected.to have_many :programs }
    it { is_expected.to have_one :master_campus }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    xit { is_expected.to validate_uniqueness_of :name }
  end
end
