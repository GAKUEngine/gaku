class CreateGakuSchoolLevelsTable < ActiveRecord::Migration
  def change
    create_table :gaku_school_levels do |t|
      t.string :title
      t.belongs_to :school

      t.timestamps
    end
  end
end
