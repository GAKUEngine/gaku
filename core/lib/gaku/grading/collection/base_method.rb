module Gaku
  module Grading
    module Collection
      class  BaseMethod
        attr_reader :gradable, :gradable_type, :students, :criteria, :results, :gradable_scope

        # Pass a gradable object [exam or assignment] and students
        def initialize(gradable, students, gradable_scope, criteria = nil)
          @gradable_scope = gradable_scope
          @gradable = gradable
          @students = students
          @criteria = criteria
          @result = []
        end

        # Obtain graded hash of results
        def grade
          case @gradable
          when Gaku::Exam
            grade_exam
          when Gaku::Assignment
            grade_assignment(@gradable)
          end

          Gaku::Grading::Collection::Result.new(@gradable.id, @result).as_json
        end

      end
    end
  end
end
