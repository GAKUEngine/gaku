class Gaku::Grading::Collection::Score < Gaku::Grading::Collection::BaseMethod

  def grade_exam
    @students.each do |student|
      @result << Gaku::Grading::Single::Score.new(@gradable, student, gradable_scope).grade_exam
    end
    @result
  end

end
