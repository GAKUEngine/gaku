class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string   :name
      t.string   :surname
      t.string   :name_reading, :default => "" 
      t.string   :surname_reading, :default =>  ""
      t.boolean  :gender
      t.string   :phone
      t.string   :email
      t.date     :birth_date
      t.date     :admitted
      t.date     :graduated

      t.timestamps
    end
  end
end
