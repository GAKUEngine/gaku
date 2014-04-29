module Gaku
  class LessonPlan < ActiveRecord::Base
    include Notes

    has_many :lessons
    has_many :attachments, as: :attachable
    belongs_to :syllabus

    validates :syllabus, presence: true
  end
end
