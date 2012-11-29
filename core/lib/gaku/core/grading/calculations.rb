module Gaku
  module Core
    module Grading
      module Calculations

        def self.included(base)
          base.send(:include, InstanceMethods)
        end

        module InstanceMethods
          def calculate_totals
            @student_total_scores = Hash.new { |hash,key| hash[key] = {} }
            @student_total_weights = Hash.new { |hash,key| hash[key] = {} }
            @exam_averages = Hash.new {0.0}
            @exam_weight_averages = Hash.new {0.0}
            @weighting_score = true

            @students.each do |student|
              @exams.each do |exam|
                @student_total_scores[student.id][exam.id] = 0.0
                @student_total_weights[student.id][exam.id] = 0.0
                exam.exam_portions.each do |portion|
                  if have_portion_score?(student, portion)
                    create_new_portion_score(student,portion)
                  else
                    add_to_student_total_score(student, exam, portion)
                    add_to_student_total_weight(student,exam, portion) if exam.use_weighting
                  end
                end
              end
            end
          end
          
          def calculate_exam_averages
            @exams.each do |exam|
              @students.each do |student|
                @exam_averages[exam.id] += @student_total_scores[student.id][exam.id]
                if exam.use_weighting
                  @exam_weight_averages[exam.id] += @student_total_weights[student.id][exam.id]
                end
              end
              @exam_averages[exam.id] = fix_digit(@exam_averages[exam.id] / @students.length, 4)
              if exam.use_weighting
                @exam_weight_averages[exam.id] = fix_digit(@exam_weight_averages[exam.id] / @students.length, 4)
              end
            end
          end

          def calculate_deviation
            @deviation = Hash.new { |hash,key| hash[key] = {} }
            @standard_deviation = 0.0
            @deviation_memo = 0.0
            @exams.each do |exam|
              @students.each do |student|
                if exam.use_weighting
                  add_to_weighted_standard_deviation(exam, student)
                else
                  add_to_standard_deviation(exam, student)
                end
              end
              standard_deviation(@standard_deviation)
             
              @students.each do |student|
                @deviation[student.id][exam.id] = 0.0
                add_to_deviation_memo(exam, student)
                add_to_deviation(exam, student)
              end
            end
          end

          def calculate_rank_and_grade
            @scores = Array.new
            populate_student_scores

            @grades = Hash.new { |hash,key| hash[key] = {} }
            grading_method = 1
            grade_calculate(grading_method)
            rank_calculate
          end

          private
            def fix_digit(num, digit_num)
              fix_num = 10 ** digit_num
              fixed_num = num * fix_num
              fixed_num.nan? ? 0 : fixed_num.truncate.to_f / fix_num.to_f
            end

            def create_new_portion_score(student, portion)
              ExamPortionScore.create(:student_id => student.id, :exam_portion_id => portion.id)
            end

            def add_to_student_total_score(student,exam, portion)
              @student_total_scores[student.id][exam.id] += student.exam_portion_scores.where(:exam_portion_id => portion.id).first.score.to_f
            end

            def have_portion_score?(student, portion)
              student.exam_portion_scores.where(:exam_portion_id => portion.id).first.nil?
            end

            def add_to_student_total_weight(student,exam, portion)
              @student_total_weights[student.id][exam.id] +=  (portion.weight.to_f / 100) * student.exam_portion_scores.where(:exam_portion_id => portion.id).first.score.to_f
            end

            def add_to_weighted_standard_deviation(exam, student)
              @standard_deviation += (@student_total_weights[student.id][exam.id] - @exam_weight_averages[exam.id]) ** 2
            end

            def add_to_standard_deviation(exam, student)
              @standard_deviation += (@student_total_scores[student.id][exam.id] - @exam_averages[exam.id]) ** 2
            end

            def standard_deviation(standard_deviation)
              @standard_deviation = Math.sqrt standard_deviation / @students.length
            end

            def add_to_deviation_memo(exam, student)
              if exam.use_weighting
                @deviation_memo = (@student_total_weights[student.id][exam.id] - @exam_weight_averages[exam.id]) / @standard_deviation
              else
                @deviation_memo = (@student_total_scores[student.id][exam.id] - @exam_averages[exam.id]) / @standard_deviation
              end
            end

            def add_to_deviation(exam, student)
              @deviation[student.id][exam.id] = @deviation_memo.nan? ? 50 : fix_digit(@deviation_memo * 10 + 50, 4)
            end

            def populate_student_scores
              @exams.each do |exam|
                if exam.use_weighting
                  @students.each do |student|
                    @scores.push [@student_total_weights[student.id][exam.id], student.id]
                  end
                else
                  @students.each do |student|
                    @scores.push [@student_total_scores[student.id][exam.id], student.id]
                  end
                end
              @scores.sort!().reverse!()
              puts "SORTED SCORES--------------------------"
              puts @scores
            end

            def grade_calculate(grading_method)
              @gradePoint = 10
              @grade_levels_deviation = [10000000000, 66, 62, 58, 55, 50, 45, 37, 0]
              @grade_levels_percent = [5, 5, 10, 10, 30, 30, 10, 100]

              @exams.each do |exam|
                case grading_method
                when 1
                  grading_method_deviation(exam)
                when 2
                  grading_method_percent(exam)
                end
                process_low_deviations(exam)
              end
            end

            def grading_method_deviation(exam)
              @grade_levels_deviation.each_with_index do |glevel, i|
                @students.each do |student|
                  if @grade_levels_deviation[i] > @deviation[student.id][exam.id] && @grade_levels_deviation[i+1] <= @deviation[student.id][exam.id]
                    @grades[exam.id][student.id] = @gradePoint
                  end
                end
                @gradePoint -= 1
              end
            end
  
            def grading_method_percent(exam)
              scores_memo = @scores.clone
              gradeNums = []
              @grade_levels_percent.each do |glevel|
                gradeNums.push((@students.length * (glevel.to_f / 100)).ceil)
              end
              gradeNums.each do |gnum|
                i = 0
                while i < gnum && scores_memo.length != 0
                  @grades[exam.id][scores_memo.shift[1]] = @gradePoint
                  i += 1
                end
                @gradePoint -= 1
              end
            end
            
            def process_low_deviations(exam)
              scores_memo = @scores.clone
              @students.each do |student|
                if exam.use_weighting
                  if @student_total_weights[student.id][exam.id] < @exam_weight_averages[exam.id] / 2 && @student_total_weights[student.id][exam.id] < 30
                    @grades[exam.id][student.id] = 2
                    if @student_total_weights[student.id][exam.id] < @exam_weight_averages[exam.id] / 4
                      @grades[exam.id][student.id] = 1
                    end
                  end
                else
                  if @student_total_scores[exam.id][student.id] < @exam_averages[exam.id] / 2 && 30
                    @grades[exam.id][student.id] = 2
                    if @student_total_scores[student.id][exam.id] < @exam_averages[exam.id] / 4
                      @grades[exam.id][student.id] = 1
                    end
                  end
                end
              end
            end

            def rank_calculate
              @rank_point = 5
              @ranks = Hash.new { |hash,key| hash[key] = {} }
              rank_levels = [15, 20]
              @exams.each do |exams|
                initial_student_rank(exam)
                rank_nums = rank_nums(rank_levels)
                rank_score(exam,rank_nums)
                rank(exam)
              end
            end

            def rank_nums(rank_levels)
              rank_nums = []
              rank_levels.each {|rlevel| rank_nums.push((@students.length * (rlevel.to_f / 100)).ceil)}
              rank_nums
            end

            def initial_student_rank(exam)
                @students.each {|student| @ranks[exam.id][student.id] = 3 }
            end

            def rank_score(exam, rank_nums)
              rank_nums.each do |rnum|
                i = 0
                while i < rnum && @scores.length != 0
                  score_memo = @scores.shift()
                  @ranks[exam.id][score_memo[1]] = @rank_point
                  rnum += 1 if @scores.length != 0 and score_memo[0] == @scores[0][0]
                  i += 1
                end
               @rank_point -= 1
              end
            end

            def rank(exam)
              @scores.each do |score|
                if @grades[exam.id][score[1]] == 3
                  @ranks[exam.id][score[1]] = 2
                elsif @grades[exam.id][score[1]] < 3
                  @ranks[exam.id][score[1]] = 1
                end
              end
            end
          end

        end
      end
    end
  end
end