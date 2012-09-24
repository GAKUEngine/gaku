# == Schema Information
#
# Table name: schools
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  is_primary     :boolean          default(FALSE)
#  slogan         :text
#  description    :text
#  founded        :date
#  principal      :string(255)
#  vice_principal :string(255)
#  grades         :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class School < ActiveRecord::Base

	has_many :campuses

	attr_accessible :name, :is_primary, :slogan, :description, :founded, :principal, :vice_principal, :grades

end
