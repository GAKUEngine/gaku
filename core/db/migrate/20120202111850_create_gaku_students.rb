class CreateGakuStudents < ActiveRecord::Migration
  def change
    create_table :gaku_students do |t|
      t.string   :name
      t.string   :middle_name
      t.string   :surname
      t.string   :name_reading,    :default => ""
      t.string   :surname_reading, :default =>  ""
      t.boolean  :gender
      t.date     :birth_date
      t.date     :admitted
      t.date     :graduated
      t.string   :student_id_number
      t.string   :student_foreign_id_number
      t.string   :national_registration_number
      t.boolean  :is_deleted, :default => false

      t.attachment :picture

      t.references :user
      t.references :faculty
      t.references :commute_method
      t.references :scholarship_status
      t.references :enrollment_status

      t.timestamps
    end
  end
end
