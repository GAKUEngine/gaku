require 'spec_helper'

describe Gaku::Guardian do

  context "validations" do
  	let(:guardian) { stub_model(Gaku::Guardian) }

    it_behaves_like 'person'
    it_behaves_like 'addressable'
    it_behaves_like 'contactable'
    it_behaves_like 'avatarable'

    it { should belong_to :user }
    it { should have_and_belong_to_many :students }

    it { should allow_mass_assignment_of :relationship }
  end

  context 'methods' do
    xit 'primary_contact'
    xit 'primary_address'
  end

end
