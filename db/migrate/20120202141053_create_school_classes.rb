class CreateSchoolClasses < ActiveRecord::Migration
  def change
    create_table :school_classes do |t|
      t.string :code
      t.references :syllabus
      t.references :schedule
      t.references :teacher

      t.timestamps
    end
    add_index :school_classes, :syllabus_id
    add_index :school_classes, :schedule_id
    add_index :school_classes, :teacher_id
  end
end
