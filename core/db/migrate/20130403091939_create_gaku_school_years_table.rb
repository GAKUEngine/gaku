class CreateGakuSchoolYearsTable < ActiveRecord::Migration
  def change
    create_table :gaku_school_years do |t|
      t.date :starting
      t.date :ending

      t.timestamps
    end
  end
end
