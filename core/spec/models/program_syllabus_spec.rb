require 'spec_helper_models'
describe Gaku::ProgramSyllabus, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :program }
    it { is_expected.to belong_to :syllabus }
    it { is_expected.to belong_to :level }
  end

  describe 'validations' do
    # it { should validate_presence_of :level }
    it { is_expected.to validate_presence_of :syllabus }
    # it { should validate_presence_of :program }
  end
end
