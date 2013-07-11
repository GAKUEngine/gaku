require 'spec_helper'

describe Gaku::StudentAchievement do

  describe 'associations' do
    it { should belong_to :achievement }
    it { should belong_to :student }
  end

  describe 'validations' do
    it { should validate_presence_of :student_id }
    it { should validate_presence_of :achievement_id }
  end

end
