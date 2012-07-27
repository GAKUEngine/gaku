class Student < ActiveRecord::Base
  require 'csv'

  has_many :course_enrollments
  has_many :courses, :through => :course_enrollments

  has_many :class_group_enrollments
  has_many :class_groups, :through => :class_group_enrollments

  #FIXME maybe it should be reversed
  has_many :exam_scores
  has_many :exams, :through => :exam_scores
  has_many :assignment_scores

  belongs_to :user
  has_and_belongs_to_many :addresses
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

  
end



# == Schema Information
#
# Table name: students
#
#  id                   :integer         not null, primary key
#  name                 :string(255)
#  surname              :string(255)
#  name_reading         :string(255)
#  surname_reading      :string(255)
#  gender               :string(255)
#  phone                :string(255)
#  email                :string(255)
#  birth_date           :date
#  admitted             :date
#  graduated            :date
#  created_at           :datetime        not null
#  updated_at           :datetime        not null
#  user_id              :integer
#  faculty_id           :integer
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

