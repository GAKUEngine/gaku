class Student < ActiveRecord::Base
  has_many :course_enrollments
  has_many :courses, :through => :course_enrollments

  has_many :class_group_enrollments
  has_many :class_groups, :through => :class_group_enrollments

  #FIXME maybe it should be reversed
  has_many :exam_scores
  has_many :exams, :through => :exam_scores

  belongs_to :user
  belongs_to :profile
  has_and_belongs_to_many :addresses
  has_and_belongs_to_many :guardians
  has_many :contacts
  has_many :notes

  attr_accessible :name, :surname, :name_reading, :phone, :email, :birth, :gender, :admitted, :graduated,
                  :class_groups, :class_group_ids, :class_groups_attributes, :profile, :profile_attributes,
                  :guardians, :guardians_attributes, :notes, :notes_attributes

  validates :name, :surname, :presence => true

  accepts_nested_attributes_for :profile
  accepts_nested_attributes_for :guardians
  accepts_nested_attributes_for :notes
end
