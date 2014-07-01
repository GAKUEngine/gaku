module Gaku
  class StudentSelection

    class << self


      def all
        $redis.lrange(:student_selection, 0, -1)
      end

      def remove_all
        $redis.del(:student_selection)
        self.students
      end

      def add(student)
        $redis.rpush(:student_selection, student.id)
        self.students
      end

      def remove(student)
        $redis.lrem(:student_selection, 0, student.id)
        self.students
      end

      def collection(students)
        new_students = not_added_students(students)
        puts new_students.inspect
        $redis.rpush(:student_selection, new_students) unless new_students.blank?
        self.students
      end

      def remove_collection(students)
        students.each do |student|
          $redis.lrem(:student_selection, 0, student.id)
        end
        self.students
      end

      def students
        Student.where(id: all)
      end

      private

      def not_added_students(students)
        students.reject { |student| all.include?(student.id) }.map(&:id)
      end

    end

  end
end
