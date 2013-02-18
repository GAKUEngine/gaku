module Gaku
  class Student < ActiveRecord::Base

    include Person, Addresses, Contacts, Notes, Picture, Trashable

    has_many :course_enrollments
    has_many :courses, :through => :course_enrollments

    has_many :class_group_enrollments
    has_many :class_groups, :through => :class_group_enrollments

    has_many :extracurricular_activity_enrollments
    has_many :extracurricular_activities, :through => :extracurricular_activity_enrollments

    has_many :student_specialties
    has_many :specialties, :through => :student_specialties

    has_many :student_achievements
    has_many :achievements, :through => :student_achievements

    has_many :exam_portion_scores
    has_many :assignment_scores
    has_many :attendances
    has_many :external_school_records
    has_many :simple_grades

    belongs_to :user
    belongs_to :commute_method
    belongs_to :scholarship_status
    belongs_to :enrollment_status

    has_and_belongs_to_many :guardians, :join_table => :gaku_guardians_students

    has_paper_trail :class_name => 'Gaku::StudentVersion',
                    :on => [:update, :destroy],
                    :only => [
                               :name, :surname, :middle_name,
                               :student_id_number, :student_foreign_id_number,
                               :scholarship_status_id,
                               :commute_method_id, :enrollment_status_id,
                               :is_deleted
                             ]

    attr_accessible :admitted, :graduated,
                    :class_groups, :class_group_ids, :class_groups_attributes,
                    :guardians, :guardians_attributes,
                    :student_id_number, :student_foreign_id_number,
                    :scholarship_status_id, :enrollment_status_id, :commute_method_id


    accepts_nested_attributes_for :guardians, :allow_destroy => true


    #default_scope includes(:enrollment_status).where('gaku_enrollment_statuses.is_active = ?', true)

    def identification_number
      "%surname-%name-%id".gsub(/%(\w+)/) do |s|
        case s
        when "%name"
          name.downcase
        when "%surname"
          surname.downcase
        when "%id"
          id
        end
      end
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

  end
end
