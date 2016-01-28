class Gaku::Grading::Collection::Ordinal < Gaku::Grading::Collection::BaseMethod

  def grade_exam
    @students.each do |student|
      @result << Gaku::Grading::Single::Ordinal.new(@gradable, student, gradable_scope,criteria).grade_exam
    end
    @result
  end

end
