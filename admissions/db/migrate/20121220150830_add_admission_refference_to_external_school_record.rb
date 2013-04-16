class AddAdmissionRefferenceToExternalSchoolRecord < ActiveRecord::Migration
  def change
    change_table :gaku_external_school_records do |t|
      t.references :admission
    end
  end
end
