class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.date :birth
      t.date :admitted
      t.date :graduated

      t.timestamps
    end
  end
end
