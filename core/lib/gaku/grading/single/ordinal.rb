class Gaku::Grading::Single::Ordinal < Gaku::Grading::Single::BaseMethod
  # attr_accessor :criteria

  def grade_exam
    exam = @gradable
    percentage = Gaku::Grading::Single::Percentage.new(exam, @student, gradable_scope).grade
    @result = { id: @student.id, score: ordinal(percentage['score']) }
  end

  private

  def ordinal(percentage)
    if percentage
      criteria.sort_by(&:last).reverse.find do |_grade, min_points|
        percentage >= min_points.to_i
      end.first
    end
  end

  def criteria
    if @criteria.value?('0')
      @criteria
    else
      @criteria.merge('' => '0')
    end
  end
end
