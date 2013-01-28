class CreateGakuSchoolHistories < ActiveRecord::Migration
  def change
  	create_table :gaku_school_histories do |t|
      t.date    :beginning
      t.date    :ending
      t.string  :specialty
      t.boolean :graduated

      t.references :school
      t.references :student

      t.timestamps
  	end
  end
end
