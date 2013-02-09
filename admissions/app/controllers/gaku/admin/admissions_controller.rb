module Gaku
  module Admin
    class AdmissionsController < GakuController

      inherit_resources
      respond_to :js, :html
      respond_to :xls
      respond_to :csv, :only => :csv

      helper_method :sort_column, :sort_direction

      before_filter :load_period_method
      before_filter :load_before_index, only: [:index, :listing_admissions, :change_admission_period, :change_admission_method, 
                                                  :change_period_method]
      before_filter :load_state_records, only: [:index, :listing_admissions, :change_admission_period, :change_admission_method, 
                                                  :change_period_method, :create, :create_multiple, :change_student_state]
      before_filter :select_vars, only: [:new]
      before_filter :load_state_students, only: [:change_student_state]
      before_filter :load_selected_students, only: [:student_chooser, :create_multiple]

      def change_admission_period
      end

      def change_admission_method
      end

      def change_period_method
      end

      def index
      end

      def listing_admissions
      end

      def change_student_state
        
        if params[:admit_students]
          admit_students(@state_students)
        else
          @next_state = AdmissionPhaseState.find(params[:state_id])

          @state_students.each  do |student|
            phase = @next_state.admission_phase
            @admission_record = student.admission.find_record_by_phase(phase.id)
            @old_state_id = @admission_record.admission_phase_state_id

            @admission_method = phase.admission_method

            unless (@next_state.id == @admission_record.admission_phase_state_id)
              if @next_state.auto_admit == true
                student.admission.admit(student)
              elsif @next_state.auto_progress == true
                next_phase = AdmissionPhase.find_next_phase(phase)
                @new_state = next_phase.admission_phase_states.first
                student.admission.progress_to_next_phase(phase)
              end
              @admission_record.admission_phase_state_id = @next_state.id
              @admission_record.save
            end
          end
          render 'change_student_state'
        end
      end

      def listing_applicants
        @search = Student.unscoped.search(params[:q])
        @students = @search.result
      end

      def new
        @admission = Admission.new
        @student = @admission.build_student
        @method_admissions = Admission.where(:admission_method_id => @admission_method.id)
        @applicant_max_number = !@method_admissions.empty? ? (@method_admissions.map(&:applicant_number).max + 1) : @admission_method.starting_applicant_number
      end

      def create
        @admission = Admission.new(params[:admission])
        if @admission.save
          @admission_method = @admission.admission_method
          @admission_period = AdmissionPeriod.find(params[:admission][:admission_period_id])
          admission_phase = @admission_method.admission_phases.first
          @admission_phase_state = admission_phase.admission_phase_states.first
          @admission_phase_record = AdmissionPhaseRecord.create(
                                                :admission_phase_id => admission_phase.id,
                                                :admission_phase_state_id => @admission_phase_state.id,
                                                :admission_id => @admission.id)

          @admission.change_student_to_applicant
          render 'create'
        end
      end

      def student_chooser
        @admission = Admission.new
        @search = Student.only_applicants.search(params[:q])
        @students = @search.result

        @admissions = Admission.all

        @enrolled_students = Admission.where(:admission_period_id => params[:admission_period_id], :admission_method_id => params[:admission_method_id]).map {|i| i.student_id.to_s }

        @method_admissions = Admission.where(admission_method_id: @admission_method.id)
        @applicant_max_number = !@method_admissions.empty? ? (@method_admissions.map(&:applicant_number).max + 1) : @admission_method.starting_applicant_number

        respond_to do |format|
          format.js
        end
      end

      def create_multiple
        @err_enrollments = []
        @enrollments = []
        @admission_records = []
        @admission_method = AdmissionMethod.find(params[:admission_method_id])
        @admission_period = AdmissionPeriod.find(params[:admission_period_id])
        @selected_students.each { |student|
          student_id = student.split("-")[1].to_i
          admission = Admission.new( admission_period_id: @admission_period.id,
                                      admission_method_id: @admission_method.id,
                                      student_id: student_id )
          if  admission.save
            @enrollments << admission
            # TODO change the selected phase
            admission_phase = admission.admission_method.admission_phases.first
            # TODO change the selected phase state
            @admission_phase_state = admission_phase.admission_phase_states.first
            @admission_records << AdmissionPhaseRecord.create(
                                        :admission_phase_id => admission_phase.id,
                                        :admission_phase_state_id => @admission_phase_state.id,
                                        :admission_id => admission.id)
            admission.update_column(:admission_phase_record_id, @admission_records.last.id)

            admission.change_student_to_applicant
          else
            @err_enrollments << admission
          end
        }
        show_flashes(@enrollments,@err_enrollments)
      end

      def soft_delete
        @admission = Admission.find(params[:id])
        @admission.update_attribute('is_deleted', true)
        @admission.admission_phase_records.each {|rec|
          rec.update_attribute('is_deleted', true)
        }
      end

      private
        def load_period_method
          @admission_periods = Gaku::AdmissionPeriod.all

          if params[:admission_period_id]
            @admission_period = AdmissionPeriod.find(params[:admission_period_id])
          end
          if @admission_period.nil? && !@admission_periods.nil?
            @admission_period = @admission_periods.last
          end

          if params[:admission_method_id]
            @admission_method = AdmissionMethod.find(params[:admission_method_id])
          else
            if !@admission_period.nil? && !@admission_period.admission_methods.nil?
              @admission_method = @admission_period.admission_methods.first
            end
          end

          if @admission_period
            @admission_methods = @admission_period.admission_methods
          end
          @admission_params = {}
          @admission_params[:admission_period_id] = @admission_period.id
          @admission_params[:admission_method_id] = @admission_method.id if !@admission_method.nil?

        end

        def load_before_index
          @search = Student.unscoped.search(params[:q])
          @students = @search.result
          @class_groups = ClassGroup.all
          @courses = Course.all
        end

        def load_state_students
          @state_students = []

          params[:student_ids].each do |id|
            @state_students << Student.unscoped.find(id)
          end
        end

        def load_selected_students
          if params[:selected_students].nil? 
            @selected_students = [] 
          else
            @selected_students = params[:selected_students]
          end
        end

        def load_state_records
          #puts "load_state_records kaishi-"

          @students = []
          @state_records = AdmissionPhaseRecord.all
          @state_records.each {|record|
            total_score = 0
            student_graded = false
            phase = record.admission_phase
            if !phase.exam.nil?
              phase.exam.exam_portions.each do |exam_portion|
                portion_score = Gaku::ExamPortionScore.find_by_exam_portion_id_and_student_id(exam_portion.id,  record.admission.student.id)
                if !portion_score.nil?
                  student_graded = true
                  total_score += portion_score.score.to_i
                end
              end
            end
            if student_graded
              exam_score = total_score
            else
              exam_score = t('exams.not_graded')
            end


            # 中学校名抽出処理

            #puts "record.admission.student dayo-"
            #puts record.admission.student.simple_grades

            # if record.admission.student.external_school_record.school_id.nil?
              # school_name = "中学校が登録されていません"
            # else
              # school_name = SchollHistory.find_by_id(record.admission.student.external_school_record.school_id)
            # end


            @students << {
              :state_id => record.admission_phase_state_id,
              :student => record.admission.student,
              :exam_score => exam_score
            }
          }
        end

        def select_vars
          @class_groups = get_class_groups
          @class_group_id ||= params[:class_group_id]
          @scholarship_statuses = get_scholarship_statuses
        end

        def get_class_groups
          ClassGroup.all
        end

        def get_scholarship_statuses
          ScholarshipStatus.all
        end


        def sort_column
          Student.column_names.include?(params[:sort]) ? params[:sort] : "surname"
        end

        def sort_direction
          %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
        end

        def show_flashes(admissions, err_admissions)
          notice = ""
          unless admissions.empty?
            admissions.each do |admission|
              student = Student.unscoped.find(admission.student_id)
              #TODO localize the text
              notice+= "<p>" + student.name + " " + student.surname + ": " + "<span style='color:green;'> Admission successfully  created.</span>" + "</p>"
            end
            flash.now[:success] = notice.html_safe
          end
          unless err_admissions.empty?
            err_admissions.each {|admission|
              student = Student.unscoped.find(admission.student_id)
              #TODO localize the text
              notice+= "<p>" + student.name + " " + student.surname + ": <span style='color:orange;'>" + admission.errors.full_messages.join(", ") + "</span></p>"
            }
            flash.now[:error] = notice.html_safe
          end
        end
        
        def admit_students(students)
          students.each  do |student|
            admission = student.admission
            admission.admit(student)
          end
          #@state_students = students
          #render 'admit_students'
        end
    end
  end
end
