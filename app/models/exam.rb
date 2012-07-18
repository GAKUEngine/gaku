class Exam < ActiveRecord::Base

  has_many :exam_scores 
  has_many :exam_portions
  has_many :exam_portion_scores, :through => :exam_portions
  has_and_belongs_to_many :syllabuses
  has_one :grading_method

  has_one :master,
      :class_name => 'ExamPortion',
      :conditions => ["#{ExamPortion.quoted_table_name}.is_master = ?", true]

  attr_accessible :name, :description, :weight, :dynamic_scoring, :adjustments, :exam_portions_attributes

  accepts_nested_attributes_for :exam_portions

  validates :name, :presence => true
  validates :weight, :numericality => { :greater_than_or_equal_to => 0 }


  after_create :set_master_defaults
  after_save :save_master
  after_initialize :ensure_master

  def ensure_master
    return unless new_record?
    self.master ||= ExamPortion.new
  end

  private

    def set_master_defaults
      master.is_master = true
    end

    def save_master
      master.save if master && (master.changed? || master.new_record?)
    end

end


# == Schema Information
#
# Table name: exams
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  description     :text
#  adjustments     :text
#  weight          :float
#  dynamic_scoring :boolean
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

