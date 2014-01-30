class AddFieldsToExternalSchoolRecord < ActiveRecord::Migration
  def change
    add_column :gaku_external_school_records, :units_absent, :integer
    add_column :gaku_external_school_records, :total_units,  :integer
  end
end
