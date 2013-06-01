class CreateGakuAttendanceTypesTranslations < ActiveRecord::Migration
  def up
    Gaku::AttendanceType.create_translation_table! name: :string
  end

  def down
    Gaku::AttendaceType.drop_translation_table!
  end
end
