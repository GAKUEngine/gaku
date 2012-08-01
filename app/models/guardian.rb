# == Schema Information
#
# Table name: guardians
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  surname         :string(255)
#  name_reading    :string(255)
#  surname_reading :string(255)
#  relationship    :string(255)
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Guardian < ActiveRecord::Base
  belongs_to :user
  has_many :guardian_addresses
  has_many :addresses, :through => :guardian_addresses
  has_and_belongs_to_many :students
  has_many :contacts

  attr_accessible :name, :surname, :name_reading, :surname_reading, :relationship, :contacts, :contacts_attributes
  validates :name, :surname, :presence => true

  accepts_nested_attributes_for :contacts, :allow_destroy => true
end
