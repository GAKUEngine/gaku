module Gaku
  class Student < ActiveRecord::Base

    has_many :course_enrollments
    has_many :courses, :through => :course_enrollments

    has_many :class_group_enrollments
    has_many :class_groups, :through => :class_group_enrollments

    has_many :student_specialties
    has_many :specialities, :through => :student_specialties

    has_many :student_addresses
    has_many :addresses, :through => :student_addresses

    has_many :exam_portion_scores
    has_many :assignment_scores

    has_many :contacts
    has_many :notes, as: :notable
    has_many :attendances
    has_many :enrollment_statuses

    has_many :achievements
    has_many :school_histories
    has_many :simple_grades

    belongs_to :user
    belongs_to :commute_method
    belongs_to :scholarship_status

    has_and_belongs_to_many :guardians, :join_table => :gaku_guardians_students

    has_paper_trail :on => [:update, :destroy],
                    :only => [
                               :name, :surname, :middle_name,
                               :student_id_number, :student_foreign_id_number, :scholarship_status_id,
                               :commute_method_id
                             ]

    attr_accessible :name, :surname, :middle_name, :name_reading, :surname_reading,
                    :birth_date, :gender,
                    :admitted, :graduated,
                    :class_groups, :class_group_ids, :class_groups_attributes,
                    :guardians, :guardians_attributes,
                    :notes, :notes_attributes,
                    :addresses, :addresses_attributes,
                    :picture,
                    :student_id_number, :student_foreign_id_number, :scholarship_status_id

    has_attached_file :picture, :styles => {:thumb => "256x256>"}, :default_url => "/assets/pictures/thumb/missing.png"

    validates_presence_of :name, :surname

    accepts_nested_attributes_for :guardians, :allow_destroy => true
    accepts_nested_attributes_for :notes,     :allow_destroy => true
    accepts_nested_attributes_for :addresses, :allow_destroy => true
    accepts_nested_attributes_for :contacts,  :allow_destroy => true


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

  end
end
