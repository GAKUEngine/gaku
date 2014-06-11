module Gaku
  class StudentSelection

    class << self

      def all
        $redis.lrange(:student_selection, 0, -1).map! { |x| JSON.parse(x) }
      end

      def remove_all
        $redis.del(:student_selection)
        self.all
      end

      def add(student)
        $redis.rpush(:student_selection, json_for(student))
        self.all
      end

      def remove(student)
        $redis.lrem(:student_selection, 0, json_for(student))
        self.all
      end

      private

      def json_for(student)
        { id: "#{student.id}", full_name: "#{student.surname} #{student.name}" }.to_json
      end

    end

  end
end
