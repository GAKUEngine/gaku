# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  address1   :string(255)
#  address2   :string(255)
#  city       :string(255)
#  zipcode    :string(255)
#  state      :string(255)
#  state_name :string(255)
#  past       :boolean          default(FALSE)
#  country_id :integer
#  state_id   :integer
#  faculty_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string(255)
#

class Address < ActiveRecord::Base 
  belongs_to :country
  belongs_to :state
 
  has_many :student_addresses
  has_many :students, :through => :student_addresses
  has_many :guardian_addresses
  has_many :guardians, :through => :guardian_addresses

  validates :address1, :city, :country, :presence => true

  attr_accessible :title, :address1, :address2, :city, :zipcode, :state , :state_name, :past, :country_id, :state_id, :student_id

  def self.default
    country = Country.find(Config[:default_country_numcode]) rescue Country.first
    new({:country => country}, :without_protection => true)
  end

  def state_text
    state.nil? ? state_name : (state.abbr.blank? ? state.name : state.abbr)
  end

  def same_as?(other)
    return false if other.nil?
    attributes.except('id', 'updated_at', 'created_at') == other.attributes.except('id', 'updated_at', 'created_at')
  end

  alias same_as same_as?

  def clone
    self.class.new(self.attributes.except('id', 'updated_at', 'created_at'))
  end

  def ==(other_address)
    self_attrs = self.attributes
    other_attrs = other_address.respond_to?(:attributes) ? other_address.attributes : {}

    [self_attrs, other_attrs].each { |attrs| attrs.except!('id', 'created_at', 'updated_at') }

    self_attrs == other_attrs
  end

  def empty?
    attributes.except('id', 'created_at', 'updated_at', 'country_numcode').all? { |_, v| v.nil? }
  end

  def check_primary?(student)
    @student_address = StudentAddress.find_by_student_id_and_address_id(student.id, self.id)
    @student_address.is_primary? ? true : false
  end
  
end

