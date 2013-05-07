module Gaku
  class ExamSyllabus < ActiveRecord::Base

    attr_accessible :exam_id

    belongs_to :syllabus, counter_cache: :exams_count
    belongs_to :exam

    validates_presence_of [:exam_id, :syllabus_id]

    validates :syllabus_id,
              uniqueness: {
                            scope: :exam_id,
                            message: I18n.t(:'exam.already_added')
                          }

  end
end
