class CreateGakuProgramSpeciatiesTable < ActiveRecord::Migration
  def change
    create_table :gaku_program_specialties do |t|
      t.references :program
      t.references :specialty
    end
  end
end
