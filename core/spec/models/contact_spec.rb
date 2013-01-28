require 'spec_helper'

describe Gaku::Contact do

	let(:student) { create(:student) }

  context "validations" do
    it { should belong_to(:contact_type) }
    it { should belong_to(:contactable) }

    it { should validate_presence_of(:data) }
    it { should validate_presence_of(:contact_type_id) }
  end

end
