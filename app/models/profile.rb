class Profile < ActiveRecord::Base
  attr_accessible :email, :birth_date
end
# == Schema Information
#
# Table name: profiles
#
#  id         :integer         not null, primary key
#  email      :string(255)
#  birth_date :datetime
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

