# == Schema Information
#
# Table name: semesters
#
#  id             :integer          not null, primary key
#  starting       :date
#  ending         :date
#  class_group_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Semester < ActiveRecord::Base
  belongs_to :class_group
  
  attr_accessible :starting, :ending, :class_group_id 

  validates :class_group_id, :uniqueness => {:scope => [:starting, :ending], :message =>  I18n.t('semesters.uniqueness')}
  validate :ending_after_starting

  private

  def ending_after_starting
  	if self.starting > self.ending
			errors.add(:ending, I18n.t('semesters.ending_after_starting'))
  	end
  end
end
