class CreateGakuGuardiansTable < ActiveRecord::Migration
  def change
    create_table :gaku_guardians do |t|
      t.string   :name
      t.string   :surname
      t.string   :middle_name
      t.string   :name_reading,        default: ''
      t.string   :middle_name_reading, default: ''
      t.string   :surname_reading,     default: ''
      t.boolean  :gender
      t.date     :birth_date
      t.string   :relationship
      t.boolean  :is_deleted, default: false

      t.references :user

      t.timestamps
    end
  end
end
