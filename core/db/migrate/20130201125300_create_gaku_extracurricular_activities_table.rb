class CreateGakuExtracurricularActivitiesTable < ActiveRecord::Migration
  def change
    create_table :gaku_extracurricular_activities do |t|
      t.string   :name

      t.timestamps
    end
  end
end
