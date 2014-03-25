class AddTimeFormat24ToPresetsTable < ActiveRecord::Migration
  def change
    add_column :gaku_presets, :time_format_24, :boolean, default: true
  end
end
