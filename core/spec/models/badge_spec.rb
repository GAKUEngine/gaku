require 'spec_helper_models'

describe Gaku::Badge do

  describe 'associations' do
    it { should belong_to :badge_type }
    it { should belong_to :student }
  end

  describe 'validations' do
    it { should validate_presence_of :student_id }
    it { should validate_presence_of :badge_type_id }
  end

end
