class CreateGakuPastSchools < ActiveRecord::Migration
  def change
  	create_table :gaku_past_schools do |t|
      t.references :school

      t.timestamps
  	end
  end
end
