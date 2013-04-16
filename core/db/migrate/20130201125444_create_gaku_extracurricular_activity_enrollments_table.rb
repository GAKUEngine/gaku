class CreateGakuExtracurricularActivityEnrollmentsTable < ActiveRecord::Migration
  def change
    create_table :gaku_extracurricular_activity_enrollments do |t|
      t.references :extracurricular_activity
      t.references :student

      t.timestamps
    end
  end
end
