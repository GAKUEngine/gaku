module Gaku
  class Students::ExternalSchoolRecordsController < GakuController

    respond_to :js, only: %i( new create destroy edit update )

    before_action :set_student
    before_action :set_schools, only: %i( new edit )
    before_action :set_external_school_record, only: %i( edit update )

    def new
      @external_school_record = ExternalSchoolRecord.new
      respond_with @external_school_record
    end

    def create
      @external_school_record = ExternalSchoolRecord.new(external_school_record_params)
      if @external_school_record.save
        set_count
        respond_with @external_school_record
      else
        set_count
        render :new
      end
    end


    def edit
      respond_with @external_school_record
    end

    def update
      @external_school_record.update(external_school_record_params)
      respond_with @external_school_record
    end

    def destroy
      @external_school_record = ExternalSchoolRecord.find(params[:id])
      @external_school_record.destroy
      set_count
      respond_with @external_school_record
    end

    private

    def external_school_record_params
      params.require(:external_school_record).permit([:school_id, :student_id, :beginning, :ending])
    end

    def set_student
      @student = Student.find(params[:student_id])
    end

    def set_schools
      @schools = School.all
    end

    def set_external_school_record
      @external_school_record = ExternalSchoolRecord.find(params[:id])
    end

    def set_count
      @count = @student.reload.external_school_records_count
    end

  end
end
