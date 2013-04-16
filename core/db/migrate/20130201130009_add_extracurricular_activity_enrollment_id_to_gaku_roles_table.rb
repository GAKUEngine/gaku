class AddExtracurricularActivityEnrollmentIdToGakuRolesTable < ActiveRecord::Migration
  def change
    change_table :gaku_roles do |t|
      t.references :extracurricular_activity_enrollment
    end
  end
end
