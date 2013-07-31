class CreateGakuTemplatesTable < ActiveRecord::Migration
  def change
    create_table :gaku_templates do |t|
      t.attachment        :file
      t.string            :name
      t.string            :context
      t.boolean           :is_locked, default: false
    end
  end
end
