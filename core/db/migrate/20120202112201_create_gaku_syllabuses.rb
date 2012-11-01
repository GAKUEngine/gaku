class CreateGakuSyllabuses < ActiveRecord::Migration
  def change
    create_table :gaku_syllabuses do |t|
      t.string   :name
      t.string   :code
      t.text     :description
      t.integer  :credits
      t.integer  :hours

      t.timestamps
    end
  end
end
