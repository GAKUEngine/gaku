module Gaku
  module Grading
    module Collection
      class  Result

        def initialize(exam_id, result)
          @exam_id = exam_id
          @result = result
        end

        def as_json
          { exam_id: @exam_id, student_results: @result }.as_json
        end

      end
    end
  end
end
