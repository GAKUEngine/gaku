require 'spec_helper_models'

describe Gaku::SimpleGrade, type: :model do

  describe 'associations' do
    it { should belong_to :simple_grade_type }
    it { should belong_to :student }
  end

  describe 'validations' do
    it { should validate_presence_of :simple_grade_type_id }
    it { should validate_presence_of :student_id }
    it { should validate_presence_of :score }
  end

end
