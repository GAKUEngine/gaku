# == Schema Information
#
# Table name: students
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  surname              :string(255)
#  name_reading         :string(255)      default("")
#  surname_reading      :string(255)      default("")
#  gender               :boolean
#  phone                :string(255)
#  email                :string(255)
#  birth_date           :date
#  admitted             :date
#  graduated            :date
#  user_id              :integer
#  faculty_id           :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

class Student < ActiveRecord::Base
  require 'csv'

  has_many :course_enrollments
  has_many :courses, :through => :course_enrollments

  has_many :class_group_enrollments
  has_many :class_groups, :through => :class_group_enrollments

  #FIXME maybe it should be reversed
  has_many :exam_portion_scores
  has_many :assignment_scores

  belongs_to :user

  has_many :student_addresses
  has_many :addresses, :through => :student_addresses

  has_and_belongs_to_many :guardians
  has_many :contacts
  has_many :notes

  attr_accessible :name, :surname, :name_reading, :surname_reading, :phone, :email, :birth_date, :gender, :admitted, :graduated,
                  :class_groups, :class_group_ids, :class_groups_attributes,
                  :guardians, :guardians_attributes, :notes, :notes_attributes, :addresses, :addresses_attributes, 
                  :picture

  has_attached_file :picture, :styles => {:thumb => "256x256>"}, :default_url => "/assets/pictures/thumb/missing.png"

  validates :name, :surname, :presence => true

  accepts_nested_attributes_for :guardians, :allow_destroy => true
  accepts_nested_attributes_for :notes, :allow_destroy => true
  accepts_nested_attributes_for :addresses, :allow_destroy => true

  # methods for json student chooser returning
  
  def class_group_widget
    cg = self.class_groups.last
    cg.blank? ? nil : cg
  end

  def seat_number_widget
    sn = self.class_group_enrollments.last
    sn.blank? ? nil : sn.seat_number
  end

  # need modify when primary columns is added
  def address_widget
    pa = self.addresses.first
    pa.blank? ? nil : pa.city 
  end
  
  def primary_address
    self.student_addresses.where(:is_primary => true).first.address
  end
end



