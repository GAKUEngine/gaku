class CreateGakuProgramsTable < ActiveRecord::Migration
  def change
    create_table :gaku_programs do |t|
      t.string :name
      t.text   :description

      t.references :school
      t.timestamps
    end
  end
end
