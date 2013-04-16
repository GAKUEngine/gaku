class CreateGakuCommuteMethodTypeTranslations < ActiveRecord::Migration
  def up
    Gaku::CommuteMethodType.create_translation_table! :name => :string
  end

  def down
    Gaku::CommuteMethodType.drop_translation_table!
  end
end
