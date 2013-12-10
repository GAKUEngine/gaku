class AddDeletedFields < ActiveRecord::Migration
  def change

    change_table :gaku_addresses  do |t|
      t.boolean :deleted, default: false
    end

    change_table :gaku_attachments  do |t|
      t.boolean :deleted, default: false
    end

    change_table :gaku_class_groups  do |t|
      t.boolean :deleted, default: false
    end

    change_table :gaku_contacts  do |t|
      t.boolean :deleted, default: false
    end

    change_table :gaku_course_groups  do |t|
      t.boolean :deleted, default: false
    end

    change_table :gaku_courses do |t|
      t.boolean :deleted, default: false
    end

    change_table :gaku_exams do |t|
      t.boolean :deleted, default: false
    end

    change_table :gaku_extracurricular_activities do |t|
      t.boolean :deleted, default: false
    end

    change_table :gaku_guardians do |t|
      t.boolean :deleted, default: false
    end

    change_table :gaku_students do |t|
      t.boolean :deleted, default: false
    end

    change_table :gaku_syllabuses do |t|
      t.boolean :deleted, default: false
    end

    change_table :gaku_teachers do |t|
      t.boolean :deleted, default: false
    end

  end
end
