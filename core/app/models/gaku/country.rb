# == Schema Information
#
# Table name: countries
#
#  id       :integer          not null, primary key
#  iso_name :string(255)
#  iso      :string(255)
#  iso3     :string(255)
#  name     :string(255)
#  numcode  :integer
#
module Gaku 
	class Country < ActiveRecord::Base
	  has_many :states, :order => "name ASC" , :foreign_key => 'country_numcode', :primary_key => 'numcode'
	  
	  validates_presence_of :name, :iso_name

	  def <=>(other)
	    name <=> other.name
	  end

	  def to_s
	    name
	  end
	end
end
