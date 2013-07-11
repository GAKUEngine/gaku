require 'spec_helper'

describe Gaku::ContactType do

  describe 'validations' do
    it { should validate_presence_of :name }
  end

end
