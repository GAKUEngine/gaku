class AddCounterCache < ActiveRecord::Migration
  def up

    add_column :gaku_students, :addresses_count, :integer, :default => 0
    add_column :gaku_students, :contacts_count, :integer, :default => 0
    Gaku::Student.find_each do |e|
      e.update_attribute(:addresses_count, e.addresses.length)
      e.update_attribute(:contacts_count, e.contacts.length)
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
    Gaku::Teacher.find_each do |e|
      e.update_attribute(:addresses_count, e.addresses.length)
      e.update_attribute(:contacts_count, e.contacts.length)
      e.save
    end

    add_column :gaku_campuses, :contacts_count, :integer, :default => 0
    Gaku::Campus.find_each do |e|
      e.update_attribute(:contacts_count, e.contacts.length)
      e.save
    end

  end

  def down
    remove_column :gaku_students, :addresses_count
    remove_column :gaku_students, :contacts_count

    remove_column :gaku_guardians, :addresses_count
    remove_column :gaku_guardians, :contacts_count

    remove_column :gaku_teachers, :addresses_count
    remove_column :gaku_teachers, :contacts_count

    remove_column :gaku_campuses, :contacts_count
  end
end
