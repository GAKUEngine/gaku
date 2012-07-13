require 'spec_helper'

describe Note do

  context "validations" do 
  	it { should have_valid_factory(:note) }
  	it { should belong_to(:student) }
  end
  
end# == Schema Information
#
# Table name: notes
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  content    :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  student_id :integer
#

