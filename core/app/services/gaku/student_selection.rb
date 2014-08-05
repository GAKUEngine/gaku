module Gaku
  class StudentSelection

    attr_accessor :user

    def initialize(user)
      @user = user
    end

    def all
      $redis.lrange(user_selection, 0, -1)
    end

    def remove_all
      $redis.del(user_selection)
      self.students
    end

    def add(student)
      $redis.rpush(user_selection, student.id)
      self.students
    end

    def remove(student)
      $redis.lrem(user_selection, 0, student.id)
      self.students
    end

    def collection(students)
      new_students = not_added_students(students)
      $redis.rpush(user_selection, new_students) unless new_students.blank?
      self.students
    end

    def remove_collection(students)
      students.each do |student|
        $redis.lrem(user_selection  , 0, student.id)
      end
      self.students
    end

    def students
      Student.where(id: all)
    end

    private

    def user_selection
      %Q(user:#{user.id}:student_selection)
    end

    def not_added_students(students)
      students.reject { |student| all.include?(student.id) }.map(&:id)
    end

  end
end
