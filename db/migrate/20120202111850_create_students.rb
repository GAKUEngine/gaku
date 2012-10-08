class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string   :name
      t.string   :middle_name
      t.string   :surname
      t.string   :name_reading, :default => ""
      t.string   :surname_reading, :default =>  ""
      t.boolean  :gender
      t.string   :phone
#      t.string   :encrypted_name
#      t.string   :encrypted_surname
#      t.string   :encrypted_name_reading, :default => ""
#      t.string   :encrypted_surname_reading, :default =>  ""
#      t.string   :encrypted_phone
      t.string   :email
      t.date     :birth_date
      t.date     :admitted
      t.date     :graduated
      t.string   :student_id_number
      t.string   :student_foreign_id_number
      t.string   :national_registration_number

      t.references :user
      t.references :faculty
      t.references :commute_method
      t.timestamps
    end
  end
end
