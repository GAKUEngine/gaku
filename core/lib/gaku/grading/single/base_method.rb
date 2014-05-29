module Gaku
  module Grading
    module Single
      class  BaseMethod
        attr_reader :gradable, :gradable_type, :student, :criteria, :result

        # Pass a gradable object [exam or assignment] and students
        def initialize(gradable, student, criteria = nil)
          @gradable = gradable
          @student = student
          @criteria = criteria
          @result = {}
        end

        # Obtain graded hash of results
        def grade
          case @gradable
          when Gaku::Exam
            grade_exam
          when Gaku::Assignment
            #grade_assignment
          end

          Gaku::Grading::Single::Result.new(@gradable.id, @result).as_json
        end

      end
    end
  end
end
