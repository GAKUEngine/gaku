class Presets < ActiveRecord::Migration

  def self.up
    enable_extension "hstore"

    create_table :gaku_presets do |t|
      t.string   :name
      t.boolean  :default,         default: false
      t.boolean  :active,          default: false
      t.string   :locale,          default: 'en'
      t.string   :names_order
      t.hstore   :pagination ,     default: '', null: false
      t.hstore   :person,          default: '', null: false
      t.hstore   :chooser_fields,  default: '', null: false
      t.hstore   :address,         default: '', null: false
      t.hstore   :grading,         default: '', null: false
      t.hstore   :export_formats,  default: '', null: false

      t.timestamps
    end
  end

  def self.down
    drop_table :gaku_presets

    disable_extension "hstore"
  end

end
