class Gaku::Grading::Collection::Interval < Gaku::Grading::Collection::BaseMethod

  def grade_exam

    @scores = students_with_scores

    formated_student_results.each do |student|
      @result << Gaku::Grading::Single::Interval.new(@gradable, student, gradable_scope).grade_exam
    end

    @result
  end

  private

  def student_positions
    criteria.map {|key, value| [key, ( @scores.count * (value.to_f/100)).ceil] }.to_h
  end

  def students_by_score
    @scores.group_by(&:last).sort.reverse.map{|a| a.last.map(&:first)}
  end


  def interval_results
    @students_by_score = students_by_score
    student_positions.each_with_object(Hash.new{|h, k| h[k] = []}) do |( key, value), hash|

      while value > hash[key].length
        break if @students_by_score.empty?
        hash[key].push(*@students_by_score.shift)
      end

    end
  end

  def score_results
    Gaku::Grading::Collection::Score.new(@gradable, @students, gradable_scope).grade
  end

  def students_with_scores
    score_results['student_results'].each_with_object({}) do |student_result, h|
      h[student_result['id']] = student_result['score']
    end.reject {|_student_id, score| score.nil? }
  end

  def students_without_scores
    score_results['student_results'].select {|results| results['score'].nil? }.map {|x| [x['id'], x['score']]}
  end

  def formated_student_results
    interval_results.flat_map {|k, v| v.map { |x| [x, k] } }.push *students_without_scores
  end

end
