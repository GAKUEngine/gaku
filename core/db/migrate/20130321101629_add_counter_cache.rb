class AddCounterCache < ActiveRecord::Migration
  def up

    add_column :gaku_students, :addresses_count, :integer, :default => 0
    add_column :gaku_students, :contacts_count, :integer, :default => 0
    add_column :gaku_students, :notes_count, :integer, :default => 0
    add_column :gaku_students, :courses_count, :integer, :default => 0
    add_column :gaku_students, :guardians_count, :integer, :default => 0

    Gaku::Student.find_each do |e|
      e.update_attribute(:addresses_count, e.addresses.length)
      e.update_attribute(:contacts_count, e.contacts.length)
      e.update_attribute(:notes_count, e.notes.length)
      e.update_attribute(:courses_count, e.courses.length)
      e.update_attribute(:guardians_count, e.guardians.length)
      e.save
    end


    add_column :gaku_guardians, :addresses_count, :integer, :default => 0
    add_column :gaku_guardians, :contacts_count, :integer, :default => 0

    Gaku::Guardian.find_each do |e|
      e.update_attribute(:addresses_count, e.addresses.length)
      e.update_attribute(:contacts_count, e.contacts.length)
      e.save
    end

    add_column :gaku_teachers, :addresses_count, :integer, :default => 0
    add_column :gaku_teachers, :contacts_count, :integer, :default => 0
    add_column :gaku_teachers, :notes_count, :integer, :default => 0

    Gaku::Teacher.find_each do |e|
      e.update_attribute(:addresses_count, e.addresses.length)
      e.update_attribute(:contacts_count, e.contacts.length)
      e.update_attribute(:notes_count, e.notes.length)
      e.save
    end

    add_column :gaku_campuses, :contacts_count, :integer, :default => 0
    add_column :gaku_campuses, :addresses_count, :integer, :default => 0

    Gaku::Campus.find_each do |e|
      e.update_attribute(:contacts_count, e.contacts.length)
      addreses_count = e.address ? 1 : 0
      e.update_attribute(:addresses_count, addresses_count)
      e.save
    end

    add_column :gaku_lesson_plans, :notes_count, :integer, :default => 0

    Gaku::LessonPlan.find_each do |e|
      e.update_attribute(:notes_count, e.notes.length)
      e.save
    end

    add_column :gaku_syllabuses, :notes_count, :integer, :default => 0
    add_column :gaku_syllabuses, :exams_count, :integer, :default => 0

    Gaku::Syllabus.find_each do |e|
      e.update_attribute(:exams_count, e.exams.length)
      e.update_attribute(:notes_count, e.notes.length)
      e.save
    end


    add_column :gaku_class_groups, :notes_count, :integer, :default => 0

    Gaku::ClassGroup.find_each do |e|
      e.update_attribute(:notes_count, e.notes.length)
      e.save
    end

    add_column :gaku_courses, :notes_count, :integer, :default => 0
    add_column :gaku_courses, :students_count, :integer, :default => 0

    Gaku::Course.find_each do |e|
      e.update_attribute(:notes_count, e.notes.length)
      e.update_attribute(:students_count, e.students.length)
      e.save
    end

    add_column :gaku_exams, :notes_count, :integer, :default => 0

    Gaku::Exam.find_each do |e|
      e.update_attribute(:notes_count, e.notes.length)
      e.save
    end

  end

  def down
    remove_column :gaku_students, :addresses_count
    remove_column :gaku_students, :contacts_count
    remove_column :gaku_students, :notes_count
    remove_column :gaku_students, :courses_count
    remove_column :gaku_students, :guardians_count

    remove_column :gaku_guardians, :addresses_count
    remove_column :gaku_guardians, :contacts_count

    remove_column :gaku_teachers, :addresses_count
    remove_column :gaku_teachers, :contacts_count
    remove_column :gaku_teachers, :notes_count

    remove_column :gaku_campuses, :contacts_count
    remove_column :gaku_campuses, :addresses_count

    remove_column :gaku_lesson_plans, :notes_count

    remove_column :gaku_class_groups, :notes_count

    remove_column :gaku_syllabuses, :notes_count
    remove_column :gaku_syllabuses, :exams_count

    remove_column :gaku_courses, :notes_count
    remove_column :gaku_courses, :students_count

    remove_column :gaku_exams, :notes_count
  end
end
