class CreateSyllabuses < ActiveRecord::Migration
  def change
    create_table :syllabuses do |t|
      t.string   :name
      t.string   :code
      t.text     :description
      t.integer  :credits

      t.timestamps
    end
  end
end
