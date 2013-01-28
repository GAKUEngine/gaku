module Gaku
  module Admin
    class AdmissionsController < GakuController

      inherit_resources
      respond_to :js, :html
      respond_to :xls
      respond_to :csv, :only => :csv

      helper_method :sort_column, :sort_direction

      before_filter :load_period_method, :only => [:index, :listing_admissions, :change_admission_method]
      before_filter :load_before_index, :only => [:index, :listing_admissions, :change_admission_period, :change_admission_method]
      before_filter :load_state_records, :only => [:index, :listing_admissions, :change_admission_period, :change_admission_method, :create, :create_multiple, :change_student_state]
      #before_filter :load_search_object
      before_filter :select_vars, :only => [:new]
      

      def change_admission_period
        @admission_period = AdmissionPeriod.find(params[:admission_period])
        session[:admission_period_id] = @admission_period.id
        @admission_methods = @admission_period.admission_methods

        if !@admission_methods.empty?
          @admission_method = @admission_methods.first
          session[:admission_method_id] = @admission_methods.first.id
        else
          @admission_method = nil
          session[:admission_method_id] = nil
        end
      end

      def change_admission_method
        @admission_method = AdmissionMethod.find(params[:admission_method])
        session[:admission_method_id] = @admission_method.id
      end

      def index
        

      end

      def listing_admissions
      end

      def change_student_state
        @state = AdmissionPhaseState.find(params[:state_id])
        @student = Student.unscoped.find(params[:student_id])
        phase = @state.admission_phase
        @admission_record = @student.admission.admission_phase_records.find_by_admission_phase_id(phase.id)
        @old_state_id = @admission_record.admission_phase_state_id

        @admission_period = AdmissionPeriod.find(params[:admission_period_id])
        @admission_method = phase.admission_method

        if !(@state.id == @admission_record.admission_phase_state_id)
          # TODO decide how next phase should be chosen and decide for default phase states
          if @state.auto_progress == true
            @next_phase = AdmissionPhase.find_by_admission_method_id_and_position(phase.admission_method_id ,phase.position+1)
            @new_state = @next_phase.admission_phase_states.first
            #@admission_record.admission_phase_state = @state
            #@admission_record.admission_phase = @next_phase
            @new_admission_record = AdmissionPhaseRecord.new
            @new_admission_record.admission = @student.admission
            @new_admission_record.admission_phase = @next_phase
            @new_admission_record.admission_phase_state = @new_state
            @new_admission_record.save
          elsif @state.auto_admit == true
            admission_date = !@student.admission.admission_period.admitted_on.nil? ? @student.admission.admission_period.admitted_on : Date.today
            admission = @student.admission
            admission.admitted = true
            admission.save
            @student.admitted = admission_date
            # change student enrollment status
            @student.enrollment_status_id = 2
            @student.save
          end
          @admission_record.admission_phase_state_id = @state.id
          @admission_record.save
          render 'change_student_state'
        end
      end

      def admit_student
        @student = Student.unscoped.find(params[:student_id])
        admission_date = !@student.admission.admission_period.admitted_on.nil? ? @student.admission.admission_period.admitted_on : Date.today
        admission = @student.admission
        admission.admitted = true
        admission.save
        @student.admitted = admission_date
        @student.enrollment_status_id = 2
        @student.save
      end

      def listing_applicants
        @search = Student.unscoped.search(params[:q])
        @students = @search.result
      end

      def new
        @admission = Admission.new
        @student = @admission.build_student
      end

      def create
        @admission = Admission.new(params[:admission])
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
          
          @admission.student.update_column(:enrollment_status_id, Gaku::EnrollmentStatus.where(code:"applicant", name:"Applicant", is_active:true, immutable:true).first_or_create!.id)
          render 'create'
        end
      end

      def student_chooser
        @admission = Admission.new
        @search = Student.unscoped.where(:enrollment_status_id => Gaku::EnrollmentStatus.find_by_code("applicant").id).search(params[:q])
        @students = @search.result

        @admissions = Admission.all

        @enrolled_students = Admission.where(:admission_period_id => params[:admission_period_id], :admission_method_id => params[:admission_method_id]).map {|i| i.student_id.to_s }
        #@enrolled_students += Student.where("enrollment_status_id != ?", 1).map {|i| i.id.to_s }

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
        params[:selected_students].each { |student|
          student_id = student.split("-")[1].to_i
          admission = Admission.new( admission_period_id: @admission_period.id,
                                      admission_method_id: @admission_method.id,
                                      student_id: student_id )
          if  admission.save
            @enrollments << admission
            # TODO change the selected phase
            admission_phase = admission.admission_method.admission_phases.first
            # TODO change the selected phase state
            admission_phase_state = admission_phase.admission_phase_states.first
            @admission_records << AdmissionPhaseRecord.create(
                                        :admission_phase_id => admission_phase.id,
                                        :admission_phase_state_id => admission_phase_state.id,
                                        :admission_id => admission.id)
            admission.update_column(:admission_phase_record_id, @admission_records.last.id)
            # change student status
            admission.student.update_column(:enrollment_status_id, Gaku::EnrollmentStatus.where(code:"applicant", name:"Applicant", is_active:true, immutable:true).first_or_create!.id)
            
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

          if session[:admission_period_id]
            @admission_period = AdmissionPeriod.find(session[:admission_period_id])
          else
            @admission_period = @admission_periods.last
          end

          if session[:admission_method_id]
            @admission_method = AdmissionMethod.find(session[:admission_method_id])
          else
            if !@admission_period.nil? && !@admission_period.admission_methods.nil?
              @admission_method = @admission_period.admission_methods.first
            end
          end  

          if @admission_period
            @admission_methods = @admission_period.admission_methods
          end

        end

        def load_before_index
          @search = Student.unscoped.search(params[:q])
          @students = @search.result
          @class_groups = ClassGroup.all
          @courses = Course.all
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
            admissions.each {|admission|
              student = Student.unscoped.find(admission.student_id)
              notice+= "<p>" + student.name + " " + student.surname + ": " + "<span style='color:green;'> Admission successfully  created.</span>" + "</p>"
            }
            flash.now[:success] = notice.html_safe
          end
          unless err_admissions.empty?
            err_admissions.each {|admission|
              student = Student.unscoped.find(admission.student_id)
              notice+= "<p>" + student.name + " " + student.surname + ": <span style='color:orange;'>" + admission.errors.full_messages.join(", ") + "</span></p>"
            }
            flash.now[:error] = notice.html_safe
          end
      end
    end
  end
end
