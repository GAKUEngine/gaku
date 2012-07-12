require 'spec_helper'

describe Semester do

  context "validations" do 
  	it { should have_valid_factory(:semester) }
  	it { should belong_to(:class_group) }
  end
  
end# == Schema Information
#
# Table name: semesters
#
#  id             :integer         not null, primary key
#  starting       :date
#  ending         :date
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#  class_group_id :integer
#

