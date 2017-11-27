require 'spec_helper_models'
describe Gaku::ProgramSyllabus, type: :model do

  describe 'associations' do
    it { should belong_to :program }
    it { should belong_to :syllabus }
    it { should belong_to :level }
  end

  describe 'validations' do
    # it { should validate_presence_of :level }
    it { should validate_presence_of :syllabus }
    # it { should validate_presence_of :program }
  end

end
