module Gaku
  module ExamHelper
    def exam_completion_info(exam)
      @course_students ||= @course.students
      ungraded = exam.ungraded(@course_students)
      total = exam.total_records(@course_students)

      percentage = number_to_percentage exam.completion(@course_students), precision: 2

      "#{t(:'exam.completion')}:#{percentage} #{t(:'exam.graded')}:#{total - ungraded} #{t(:'exam.ungraded')}:#{ungraded} #{t(:'exam.total')}:#{total}"
    end
  end
end
