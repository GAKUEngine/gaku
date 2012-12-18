# == Schema Information
#
# Table name: students
#
#  id                           :integer          not null, primary key
#  name                         :string(255)
#  middle_name                  :string(255)
#  surname                      :string(255)
#  name_reading                 :string(255)      default("")
#  surname_reading              :string(255)      default("")
#  gender                       :boolean
#  phone                        :string(255)
#  email                        :string(255)
#  birth_date                   :date
#  admitted                     :date
#  graduated                    :date
#  student_id_number            :string(255)
#  student_foreign_id_number    :string(255)
#  national_registration_number :string(255)
#  user_id                      :integer
#  faculty_id                   :integer
#  commute_method_id            :integer
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  picture_file_name            :string(255)
#  picture_content_type         :string(255)
#  picture_file_size            :integer
#  picture_updated_at           :datetime
#
module Gaku
  class Student < ActiveRecord::Base
    
    has_many :course_enrollments
    has_many :courses, :through => :course_enrollments

    has_many :class_group_enrollments
    has_many :class_groups, :through => :class_group_enrollments

    has_many :student_specialties
    has_many :specialities, :through => :student_specialties

    has_many :exam_portion_scores
    has_many :assignment_scores

    belongs_to :user
    belongs_to :commute_method

    has_many :student_addresses
    has_many :addresses, :through => :student_addresses

    has_and_belongs_to_many :guardians, :join_table => :gaku_guardians_students
    has_many :contacts
    has_many :notes, as: :notable

    has_many :attendances
    has_many :enrollment_statuses

    belongs_to :scholarship_status
    has_many :simple_grades
    has_many :achievements
    has_many :school_histories

    has_one :admission


    attr_accessible :name, :surname, :name_reading, :surname_reading, :phone, :email, :birth_date, :gender, :admitted, :graduated,
                    :class_groups, :class_group_ids, :class_groups_attributes,
                    :guardians, :guardians_attributes, :notes, :notes_attributes, :addresses, :addresses_attributes,
                    :picture, :student_id_number, :student_foreign_id_number, :scholarship_status_id

  #  attr_encrypted :name,             :key => 'f98gd9regre9gr9gre9gerh'
  #  attr_encrypted :surname,          :key => 'f98gd9regre9gr9gre9gerh'
  #  attr_encrypted :name_reading,     :key => 'f98gd9regre9gr9gre9gerh'
  #  attr_encrypted :surname_reading,  :key => 'f98gd9regre9gr9gre9gerh'
  #  attr_encrypted :phone,            :key => 'f98gd9regre9gr9gre9gerh'


    has_attached_file :picture, :styles => {:thumb => "256x256>"}, :default_url => "/assets/pictures/thumb/missing.png"

    validates_presence_of :name, :surname

    accepts_nested_attributes_for :guardians, :allow_destroy => true
    accepts_nested_attributes_for :notes, :allow_destroy => true
    accepts_nested_attributes_for :addresses, :allow_destroy => true
    accepts_nested_attributes_for :contacts, :allow_destroy => true

    has_associated_audits
    audited

    def enrollment_status
      self.enrollment_statuses.first
    end

    # methods for json student chooser returning

    def full_name
      "#{self.surname} #{self.name}"
    end

    def scholarship
      scholarship_status.nil? ? "" : scholarship_status.name
    end

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
      self.student_addresses.where(:is_primary => true).first.try(:address)
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

  end
end
