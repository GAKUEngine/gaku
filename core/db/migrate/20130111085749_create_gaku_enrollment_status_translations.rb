class CreateGakuEnrollmentStatusTranslations < ActiveRecord::Migration
  def up
    Gaku::EnrollmentStatus.create_translation_table! :name => :string
  end

  def down
    Gaku::EnrollmentStatus.drop_translation_table!
  end
end
