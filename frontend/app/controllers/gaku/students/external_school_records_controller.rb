module Gaku
  class Students::ExternalSchoolRecordsController < GakuController

    respond_to :js, only: %i( new create destroy )

    before_action :set_student

    def new
      set_schools
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

    def set_count
      @count = @student.reload.external_school_records_count
    end

  end
end
