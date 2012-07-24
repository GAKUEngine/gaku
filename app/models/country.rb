class Country < ActiveRecord::Base
  has_many :states, :order => "name ASC" , :foreign_key => 'country_numcode'
  
  validates :name, :iso_name, :presence => true

  def <=>(other)
    name <=> other.name
  end

  def to_s
    name
  end
end
# == Schema Information
#
# Table name: countries
#
#  id       :integer         not null, primary key
#  iso_name :string(255)
#  iso      :string(255)
#  iso3     :string(255)
#  name     :string(255)
#  numcode  :integer
#

