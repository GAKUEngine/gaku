class CreateGakuLevelsTable < ActiveRecord::Migration
  def change
    create_table :gaku_levels do |t|
      t.string :name
      t.belongs_to :school

      t.timestamps
    end
  end
end
