module Gaku
  module Admin
    class AdmissionsController < GakuController

      inherit_resources
      respond_to :js, :html

      helper_method :sort_column, :sort_direction

      before_filter :load_before_index, :only => [:index, :change_admission_period, :change_admission_method]
      before_filter :load_state_records, :only => [:index, :change_admission_period, :change_admission_method, :create, :create_multiple, :change_student_state]
      before_filter :load_search_object
      before_filter :select_vars, :only => [:new]

      def change_admission_period
        @admission_period = AdmissionPeriod.find(params[:admission_period])
        @admission_methods = @admission_period.admission_methods
        @admission_method = @admission_period.admission_methods.first
      end

      def change_admission_method
        @admission_method = AdmissionMethod.find(params[:admission_method])
      end

      def change_student_state
        @state = AdmissionPhaseState.find(params[:state_id])
        @student = Student.find(params[:student_id])
        phase = @state.admission_phase
        @admission_record = @student.admission.admission_phase_records.find_by_admission_phase_id(phase.id)
        @old_state_id = @admission_record.admission_phase_state_id

        @admission_period = AdmissionPeriod.find(params[:admission_period_id])
        @admission_method = phase.admission_method

        if !(@state.id == @admission_record.admission_phase_state_id)
          # TODO decide how next phase should be chosen and decide for default phase states
          if @state.auto_progress == true
            @next_phase = AdmissionPhase.find_by_admission_method_id_and_order(phase.admission_method_id ,phase.order+1)
            @new_state = @next_phase.admission_phase_states.first
            #@admission_record.admission_phase_state = @state
            #@admission_record.admission_phase = @next_phase
            @new_admission_record = AdmissionPhaseRecord.new
            @new_admission_record.admission = @student.admission
            @new_admission_record.admission_phase = @next_phase
            @new_admission_record.admission_phase_state = @new_state
            @new_admission_record.save
            @admission_record.admission_phase_state_id = @state.id
          elsif @state.auto_admit == true
            admission_date = !@student.admission.admission_period.admitted_on.nil? ? @student.admission.admission_period.admitted_on : Date.today
            admission = @student.admission
            admission.admitted = true
            admission.save
            @student.admitted = admission_date
            @student.save
            @admission_record.admission_phase_state_id = @state.id
          else
            @admission_record.admission_phase_state_id = @state.id
          end
          @admission_record.save
          render 'change_student_state'
        end
      end

      def admit_student
        @student = Student.find(params[:student_id])
        admission_date = !@student.admission.admission_period.admitted_on.nil? ? @student.admission.admission_period.admitted_on : Date.today
        admission = @student.admission
        admission.admitted = true
        admission.save
        @student.admitted = admission_date
        @student.save
      end

      def index

        #raise @students.find_all { |h| h[:state_id] == 1 }.map { |i| i[:student] }.inspect
        #raise @students.inspect
      end

      def new
        @admission = Admission.new
        @student = @admission.build_student
      end

      def create
        @admission = Admission.new(params[:admission])
        #raise @admission.inspect
        if @admission.save
          @admission_method = @admission.admission_method
          @admission_period = AdmissionPeriod.find(params[:admission][:admission_period_id])
          # TODO change the selected phase
          admission_phase = @admission_method.admission_phases.first
          # TODO change the selected phase state
          admission_phase_state = admission_phase.admission_phase_states.first
          @admission_phase_record = AdmissionPhaseRecord.create(
                                                :admission_phase_id => admission_phase.id,
                                                :admission_phase_state_id => admission_phase_state.id,
                                                :admission_id => @admission.id)

          render 'create'

        end
      end

      def student_chooser
        @admission = Admission.new
        @search = Student.search(params[:q])
        @students = @search.result

        @admissions = Admission.all

        @enrolled_students = Admission.where(:admission_period_id => params[:admission_period_id], :admission_method_id => params[:admission_method_id]).map {|i| i.student_id.to_s }

        params[:selected_students].nil? ? @selected_students = [] : @selected_students = params[:selected_students]

        respond_to do |format|
          format.js
        end
      end

      def create_multiple
        params[:selected_students].nil? ? @selected_students = [] : @selected_students = params[:selected_students]
        @err_enrollments = []
        @enrollments = []
        @admission_records = []
        @admission_method = AdmissionMethod.find(params[:admission_method_id])
        @admission_period = AdmissionPeriod.find(params[:admission_period_id])
        params[:selected_students].each {|student|
          student_id = student.split("-")[1].to_i
          admission = Admission.new( :admission_period_id => params[:admission_period_id],
                                                  :admission_method_id => params[:admission_method_id],
                                                  :student_id => student_id)
          if  admission.save
            @enrollments << admission
            @admission_method = admission.admission_method
            # TODO change the selected phase
            admission_phase = @admission_method.admission_phases.first
            # TODO change the selected phase state
            admission_phase_state = admission_phase.admission_phase_states.first
            @admission_records << AdmissionPhaseRecord.create(:admission_phase_id => admission_phase.id,
                                        :admission_phase_state_id => admission_phase_state.id,
                                        :admission_id => admission.id)
          else
            @err_enrollments << admission
          end
        }
        notice = ""
        if !@enrollments.empty?

          @enrollments.each {|enrollment|
            student = Student.find(enrollment.student_id)
            notice+= "<p>" + student.name + " " + student.surname + ": " + "<span style='color:green;'> Admission successfully  created.</span>" + "</p>"
          }
          flash.now[:success] = notice.html_safe
        end
        if !@err_enrollments.empty?

          @err_enrollments.each {|enrollment|
            student = Student.find(enrollment.student_id)
            notice+= "<p>" + student.name + " " + student.surname + ": <span style='color:orange;'>" + enrollment.errors.full_messages.join(", ") + "</span></p>"
          }
          flash.now[:error] = notice.html_safe
        end

      end

      private
        def load_before_index
          @search = Student.search(params[:q])
          @students = @search.result
          @class_groups = ClassGroup.all
          @courses = Course.all
          @admission_periods = Gaku::AdmissionPeriod.all
          @admission_period = @admission_periods.last
          @admission_methods = @admission_periods.last.admission_methods
          @admission_method = @admission_period.admission_methods.first
        end

        def load_search_object
          @search = Student.search(params[:q])
        end

        def load_state_records
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
            @students << {
              :state_id => record.admission_phase_state_id,
              :student => record.admission.student,
              :student_id => record.admission.student.id,
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
    end
  end
end
