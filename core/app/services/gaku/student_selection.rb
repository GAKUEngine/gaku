module Gaku
  class StudentSelection
    attr_reader :student

    def initialize(student)
      @student = student
    end

    def add
      hash = { id: "#{@student.id}", full_name: "#{@student.surname} #{@student.name}" }
      $redis.rpush(:student_selection, hash.to_json)
    end

    def remove
      hash = { id: "#{@student.id}", full_name: "#{@student.surname} #{@student.name}" }
      $redis.lrem(:student_selection, 0, hash.to_json)
    end

  end
end
