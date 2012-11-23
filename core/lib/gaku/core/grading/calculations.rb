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
            @students.each do |student|
              @exams.each do |exam|
                add_to_exam_averages(exam, student, @students)
                add_to_weight_averages(exam, student) if exam.use_weighting
              end
            end
          end

          def calculate_deviation
            @deviation = Hash.new { |hash,key| hash[key] = {} }
            @standard_deviation = 0.0
            @deviation_member = 0.0
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
                add_to_deviation_member(exam, student)
                add_to_deviation(exam, student)
              end
            end
          end

          def calculate_rank_and_grade
            @grades = Hash.new { |hash,key| hash[key] = {} }
            @scores = Array.new

            populate_student_scores


            # WIP Grade Calculation -----↓

            # @grading_method = GradingMethod.find(exam.grading_method_id)
            # puts "@grading_method-------------"
            # puts @grading_method.name
            # eval @grading_method.method
            grading_method = 1

            grade_calculate(grading_method)

            # Rank Calculation -----↓
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

            def add_to_exam_averages(exam, student, students)
              @exam_averages[exam.id] += fix_digit(@student_total_scores[student.id][exam.id] / students.length,4)
            end

            def add_to_weight_averages(exam, student)
              @exam_weight_averages[exam.id] += fix_digit(@student_total_weights[student.id][exam.id],4)
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

            def add_to_deviation_member(exam, student)
              if exam.use_weighting
                @deviation_member = (@student_total_weights[student.id][exam.id] - @exam_weight_averages[exam.id]) / @standard_deviation
              else
                @deviation_member = (@student_total_scores[student.id][exam.id] - @exam_averages[exam.id]) / @standard_deviation
              end
            end

            def add_to_deviation(exam, student)
              @deviation[student.id][exam.id] = @deviation_member.nan? ? 50 : fix_digit(@deviation_member * 10 + 50, 4)
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
            end

            def grade_calculate(grading_method)
              @gradePoint = 10
              @grade_levels_deviation = [10000000000, 66, 62, 58, 55, 59, 45, 37, 0]
              @grade_levels_percent = [5, 5, 10, 10, 30, 10, 100]

              @exams.each do |exam|
                case grading_method
                when 1
                  grading_method_one(exam)
                when 2
                  grading_method_two(exam)
                end
              end
            end

            def grading_method_one(exam)
              @grade_levels_deviation.each_with_index do |glevel, i|
                @students.each do |student|
                  if @grade_levels_deviation[i] > @deviation[student.id][exam.id] && @grade_levels_deviation[i+1] <= @deviation[student.id][exam.id]
                    @grades[exam.id][student.id] = @gradePoint
                  end
                end
                @gradePoint -= 1
              end
            end
  
            def grading_method_two(exam)
              scoresMem = @scores.clone
              gradeNums = []
              @grade_levels_percent.each do |glevel|
                gradeNums.push((@students.length * (glevel.to_f / 100)).ceil)
              end
              gradeNums.each do |gnum|
                i = 0
                while i < gnum && scoresMem.length != 0
                  @grades[exam.id][scoresMem.shift[1]] = gradePoint
                  i += 1
                end
                @gradePoint -= 1
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

            def rank_score(exam,rank_nums)
              rank_nums.each do |rnum|
                i = 0
                while i < rnum && @scores.length != 0
                  scoreMem = @scores.shift()
                  @ranks[exam.id][scoreMem[1]] = @rank_point
                  rnum += 1 if @scores.length != 0 and scoreMem[0] == @scores[0][0]
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