class Guardian < ActiveRecord::Base
  belongs_to :user
  belongs_to :profile
  has_and_belongs_to_many :addresses
  has_many :contacts

  attr_accessible :relationship
end