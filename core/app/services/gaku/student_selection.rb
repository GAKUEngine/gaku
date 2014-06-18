module Gaku
  class StudentSelection

    class << self

      def all
        $redis.lrange(:student_selection, 0, -1).map! { |x| JSON.parse(x) }
      end

      def remove_all
        $redis.del(:student_selection)
        all
      end

      def add(student)
        $redis.rpush(:student_selection, json_for(student))
        all
      end

      def remove(student)
        $redis.lrem(:student_selection, 0, json_for(student))
        all
      end

      def collection(students)
        prepared_students = prepare_not_added_students(students)
        $redis.rpush(:student_selection, prepared_students) unless prepared_students.blank?
        all
      end

      def remove_collection(students)
        students.map { |student| json_for(student) }.each do |student|
          $redis.lrem(:student_selection, 0, student)
        end
        all
      end

      private

      def json_for(student)
        hash_for(student).to_json
      end

      def hash_for(student)
        { id: "#{student.id}", full_name: "#{student.surname} #{student.name}" }
      end

      def not_added_students(students)
        students.reject { |student| all.include?(hash_for(student).stringify_keys) }
      end

      def prepare_not_added_students(students)
        not_added_students(students).map { |student| json_for(student) }
      end

    end

  end
end
