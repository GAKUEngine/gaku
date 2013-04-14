class CreateGakuProgramLevelsTable < ActiveRecord::Migration
  def change
    create_table :gaku_program_levels do |t|
      t.references :program
      t.references :level
    end
  end
end
