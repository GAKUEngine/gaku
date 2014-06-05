module Gaku
  module Grading
    module Single
      class Result

        def initialize(exam_id, result)
          @exam_id = exam_id
          @result = result
        end

        def as_json
          @result.merge(exam_id: @exam_id).as_json
        end

      end
    end
  end
end
