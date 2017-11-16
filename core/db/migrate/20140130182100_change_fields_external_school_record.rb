class ChangeFieldsExternalSchoolRecord < ActiveRecord::Migration[4.2]
  def change
    add_column :gaku_external_school_records, :units_absent, :integer
    add_column :gaku_external_school_records, :total_units,  :integer
    remove_column :gaku_external_school_records, :attendance_rate
  end
end
