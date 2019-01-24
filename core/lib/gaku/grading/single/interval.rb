class Gaku::Grading::Single::Interval < Gaku::Grading::Single::BaseMethod
  def grade_exam
    @result = { id: student.first, score: student.last }
  end
end
