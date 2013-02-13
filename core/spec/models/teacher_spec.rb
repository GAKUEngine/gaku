require 'spec_helper'

describe Gaku::Teacher do

  context "validations" do

    it_behaves_like 'person'
    it_behaves_like 'addressable'
    it_behaves_like 'notable'
    it_behaves_like 'contactable'
    it_behaves_like 'thrashable'

    it { should belong_to :user }

    it { should have_attached_file :picture }

  end

end
