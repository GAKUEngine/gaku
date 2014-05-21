module Gaku
  module GradingMethods
    class  Result
      attr_reader :exam, :result

      def initialize(exam_id)
        @result = { exam_id: exam_id, student_results: [] }
      end

      def append_score(student_id, score)
        @result[:student_results]  <<  { id: student_id, score: score }
      end

      def as_json
        @result.as_json
      end

    end
  end
end
