require 'spec_helper_models'

describe Gaku::School do

  describe 'concerns' do
    it_behaves_like 'avatarable'
  end

  describe 'associations' do
    it { should have_many :levels }
    it { should have_many :campuses }
    it { should have_many :simple_grade_types }
    it { should have_many :programs }
    it { should have_one :master_campus }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
  end

end
