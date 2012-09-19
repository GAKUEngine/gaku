# == Schema Information
#
# Table name: students
#
#  id                           :integer          not null, primary key
#  encrypted_name               :string(255)
#  middle_name                  :string(255)
#  encrypted_surname            :string(255)
#  name_reading                 :string(255)      default("")
#  surname_reading              :string(255)      default("")
#  gender                       :boolean
#  encrypted_phone              :string(255)
#  email                        :string(255)
#  birth_date                   :date
#  admitted                     :date
#  graduated                    :date
#  student_id_number            :string(255)
#  student_foreign_id_number    :string(255)
#  national_registration_number :string(255)
#  user_id                      :integer
#  faculty_id                   :integer
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  picture_file_name            :string(255)
#  picture_content_type         :string(255)
#  picture_file_size            :integer
#  picture_updated_at           :datetime
#

class Student < ActiveRecord::Base
  require 'csv'

  include Tire::Model::Search
  include Tire::Model::Callbacks

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

  has_many :attendances

  attr_accessible :name, :surname, :name_reading, :surname_reading, :phone, :email, :birth_date, :gender, :admitted, :graduated,
                  :class_groups, :class_group_ids, :class_groups_attributes,
                  :guardians, :guardians_attributes, :notes, :notes_attributes, :addresses, :addresses_attributes, 
                  :picture, :student_id_number, :student_foreign_id_number

#  attr_encrypted :name,             :key => 'f98gd9regre9gr9gre9gerh'
#  attr_encrypted :surname,          :key => 'f98gd9regre9gr9gre9gerh'
#  attr_encrypted :name_reading,     :key => 'f98gd9regre9gr9gre9gerh'
#  attr_encrypted :surname_reading,  :key => 'f98gd9regre9gr9gre9gerh'
#  attr_encrypted :phone,            :key => 'f98gd9regre9gr9gre9gerh'


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


  def self.decrypt_student_fields(students)
      students_json = students.as_json(:except => [:encrypted_name, :encrypted_surname, :encrypted_name_reading, :encrypted_surname_reading, :encrypted_phone])

      i = 0
      students_json.each do |student|
        student[:name]    = students[i].name
        student[:surname] = students[i].surname
        student[:phone]   = students[i].phone
        i += 1
      end
      
      return students_json.to_json
  end

  def self.search(search_query)
    tire.search(load: true) do
      query { string Student.encrypt_name(search_query), allow_leading_wildcard: true } if search_query.present?
    end  

  end

end
