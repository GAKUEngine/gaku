class CreateGakuTeachersTable < ActiveRecord::Migration
  def change
    create_table :gaku_teachers do |t|
      t.string   :name
      t.string   :surname
      t.string   :name_reading,    :default => ""
      t.string   :surname_reading, :default =>  ""
      t.boolean  :gender
      t.date     :birth_date
      t.boolean  :is_deleted, :default => false

      t.attachment :picture

      t.references :user

      t.timestamps
    end
  end
end
