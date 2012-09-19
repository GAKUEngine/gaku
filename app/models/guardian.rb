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

#  attr_encrypted :name,             :key => 'fd8eg8gre67gre87g7rer4erg43e'
#  attr_encrypted :surname,          :key => 'fd8eg8gre67gre87g7rer4erg43e'
#  attr_encrypted :name_reading,      :key => 'fd8eg8gre67gre87g7rer4erg43e'
#  attr_encrypted :surname_reading,   :key => 'fd8eg8gre67gre87g7rer4erg43e'
#  attr_encrypted :relationship,      :key => 'fd8eg8gre67gre87g7rer4erg43e'

  accepts_nested_attributes_for :contacts, :allow_destroy => true

  def primary_contact
  	contacts.where(:is_primary => true).first
  end

  def primary_address
  	guardian_addresses.where(:is_primary => true).first.address rescue nil
  end
end
