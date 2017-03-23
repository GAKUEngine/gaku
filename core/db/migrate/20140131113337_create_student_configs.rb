class CreateStudentConfigs < ActiveRecord::Migration[4.2]
  def change
    create_table :gaku_student_configs do |t|
      t.boolean :active, default: false
      t.boolean :increment_foreign_id_code
      t.string :last_foreign_id_code
      t.boolean :show_code,             default: true
      t.boolean :show_name,             default: true
      t.boolean :show_surname,          default: true
      t.boolean :show_birth_date,       default: true
      t.boolean :show_sex,              default: true
      t.boolean :show_class_name,       default: true
      t.boolean :show_admitted_on,      default: true
      t.boolean :show_primary_address,  default: true
      t.boolean :show_primary_contact,  default: true
      t.boolean :show_assignments,      default: true

      t.timestamps
    end
  end
end
