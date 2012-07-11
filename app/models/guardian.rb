class Guardian < ActiveRecord::Base
  belongs_to :user
  belongs_to :profile
  has_and_belongs_to_many :addresses
  has_and_belongs_to_many :students
  has_many :contacts

  attr_accessible :relationship
end
# == Schema Information
#
# Table name: guardians
#
#  id           :integer         not null, primary key
#  relationship :string(255)
#  profile_id   :integer
#  user_id      :integer
#

