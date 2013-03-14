class CreateGakuScholarshipStatusTranslations < ActiveRecord::Migration
  def up
    Gaku::ScholarshipStatus.create_translation_table! :name => :string
  end

  def down
    Gaku::ScholarshipStatus.drop_translation_table!
  end
end
