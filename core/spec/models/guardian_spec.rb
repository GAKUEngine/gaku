require 'spec_helper'

describe Gaku::Guardian do

  context "validations" do
  	let(:guardian) { stub_model(Gaku::Guardian) }

    it_behaves_like 'person'

    it { should belong_to :user }
    it { should have_many :addresses }
    it { should have_many :contacts }
    it { should have_and_belong_to_many :students }

    it { should allow_mass_assignment_of :relationship }
  end

  context 'methods' do
    xit 'primary_contact'
    xit 'primary_address'
  end

end
