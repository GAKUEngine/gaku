require 'spec_helper'

describe ClassGroup do

  context "validations" do 
  	it { should have_valid_factory(:class_group) }
  	it { should have_many :class_group_enrollments }
    it { should have_many(:students) }
    it { should have_many(:courses) }
    it { should have_many(:semesters) }
  end
  
end# == Schema Information
#
# Table name: class_groups
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  grade      :integer
#  homeroom   :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  faculty_id :integer
#

