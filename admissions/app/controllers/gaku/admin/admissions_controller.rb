module Gaku
  module Admin
    class AdmissionsController < GakuController

      inherit_resources
      respond_to :js, :html
      respond_to :xls, :only => :index
      respond_to :ods, :only => :index
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
        session[:current_page] = 'admissions'
        respond_to do |format|
          format.html
          format.xls  #{ TODO render xls }
        end
      end

      def listing_admissions
        session[:current_page] = 'listing'
      end

      def change_student_state
        if params[:admit_students].present?
          admit_students(@state_students)
        elsif params[:progress_students].present?
          state = AdmissionPhaseState.find(params[:state_id])
          phase = state.admission_phase
          next_phase = AdmissionPhase.find_next_phase(phase)
          @new_state = next_phase.admission_phase_states.first
          @progress_success = Admission.progress_students(@state_students, phase)
        elsif params[:remove_students].present?
          state = AdmissionPhaseState.find(params[:current_state_id])
          @current_state_id = state.id
          phase = state.admission_phase
          @remove_success = Admission.remove_students(@state_students, phase)
        else
          @old_state = AdmissionPhaseState.find(params[:current_state_id])
          @next_state = AdmissionPhaseState.find(params[:state_id])
          phase = @next_state.admission_phase
          @admission_method = phase.admission_method
          @progress_success = Admission.change_students_state(@state_students, phase, @old_state, @next_state)
          render 'change_student_state'
        end
      end

      def listing_applicants
        @search = Student.non_deleted.search(params[:q])
        @students = @search.result.page(params[:page]).per(Preset.students_per_page)
        session[:current_page] = 'applicants'
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
          @admission_phase_state = admission_phase.get_default_state
          @admission.assign_admission_phase_record(admission_phase, @admission_phase_state)
          @admission.change_student_to_applicant
          @admission.save
          render 'create', :admission_phase_record => @admission_phase_record
        end
      end

      def student_chooser
        @admission = Admission.new
        #TODO make only_applicants to work with applicant students
        #@search = Student.only_applicants.search(params[:q])
        @search = Student.search(params[:q])
        @students = @search.result.page(params[:page]).per(Preset.students_per_page)
        @admissions = Admission.all
        query_params = {  :admission_period_id => params[:admission_period_id], 
                          :admission_method_id => params[:admission_method_id] }
        @enrolled_students = Admission.where(query_params).map {|i| i.student_id.to_s }
        @method_admissions = Admission.where(admission_method_id: @admission_method.id)
        if @applicant_max_number = !@method_admissions.empty?
          (@method_admissions.map(&:applicant_number).max + 1)
        else
          @admission_method.starting_applicant_number
        end
        respond_to do |format|
          format.js
        end
      end

      def create_multiple
        err_admissions = []
        admissions = []
        @admission_records = []
        @admission_method = AdmissionMethod.find(params[:admission_method_id])
        @method_admissions = Admission.where(:admission_method_id => @admission_method.id)
        applicant_number = !@method_admissions.empty? ? (@method_admissions.map(&:applicant_number).max + 1) : @admission_method.starting_applicant_number
   
        @selected_students.each { |student|
          student_id = student.split("-")[1].to_i
          admission = Admission.new( admission_period_id: @admission_period.id,
                                      admission_method_id: @admission_method.id,
                                      student_id: student_id,
                                      applicant_number: applicant_number )
          if  admission.save
            admissions << admission
            # TODO change the selected phase
            admission_phase = admission.admission_method.admission_phases.first
            @admission_phase_state = admission_phase.get_default_state
            @admission_records << admission.assign_admission_phase_record(admission_phase, @admission_phase_state)
            admission.change_student_to_applicant
            applicant_number += 1
          else
            err_admissions << admission
          end
        }
        show_flashes(admissions,err_admissions)
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
          @admission_params[:admission_period_id] = @admission_period.id if !@admission_period.nil?
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
          @students = []
          @state_records = AdmissionPhaseRecord.all
          @state_records.each do |record|
            if record.exam_score != nil
              exam_score = record.exam_score
            else
              exam_score = t('exams.not_graded')
            end
            @students << {
              :state_id => record.admission_phase_state_id,
              :student => record.admission.student,
              :exam_score => exam_score
            }
          end
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
            err_admissions.each do |admission|
              student = Student.unscoped.find(admission.student_id)
              #TODO localize the text
              notice+= "<p>" + student.name + " " + student.surname + ": <span style='color:orange;'>" + admission.errors.full_messages.join(", ") + "</span></p>"
            end
            flash.now[:error] = notice.html_safe
          end
        end

        def admit_students(students)
          students.each  do |student|
            admission = student.admission
            admission.admit(student)
          end
        end
    end
  end
end
