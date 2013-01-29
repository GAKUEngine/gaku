class ChangeGakuAdmissionsSchoolHistoryIdToExternalSchoolRecordId < ActiveRecord::Migration
  def up
    rename_column :gaku_admissions, :school_history_id, :external_school_record_id
  end

  def down
  end
end
