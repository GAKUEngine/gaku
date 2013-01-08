class AddAdmissionRefferenceToSchoolHistory < ActiveRecord::Migration
  def change
    change_table :gaku_school_histories do |t|
      t.references :admission
    end
  end
end
