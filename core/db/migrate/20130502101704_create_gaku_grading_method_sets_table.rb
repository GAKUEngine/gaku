class CreateGakuGradingMethodSetsTable < ActiveRecord::Migration
  def change
    create_table :gaku_grading_method_sets do |t|
      t.string :name
      t.boolean :primary, default: false
      t.boolean :display_deviation, default: true
      t.boolean :display_rank, default: true
      t.boolean :rank_order, default: true

      t.timestamps
    end
  end
end
