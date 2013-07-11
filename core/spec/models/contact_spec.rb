require 'spec_helper'

describe Gaku::Contact do

  describe 'associations' do
    it { should belong_to :contact_type }
    it { should belong_to :contactable }
  end

  describe 'validations' do
    it { should validate_presence_of :data }
    it { should validate_presence_of :contact_type_id }
  end

end
