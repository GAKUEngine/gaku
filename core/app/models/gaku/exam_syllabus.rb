module Gaku
  class ExamSyllabus < ActiveRecord::Base

    belongs_to :syllabus, counter_cache: :exams_count
    belongs_to :exam

    validates :exam_id, :syllabus_id, presence: true

    validates :syllabus_id,
              uniqueness: {
                            scope: :exam_id,
                            message: I18n.t(:'exam.already_added')
                          }

  end
end
