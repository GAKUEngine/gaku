module Gaku
  module PresetsHelper

    def chooser_preset
      @chooser_preset ||= Gaku::Preset.chooser_table_fields
    end

    def enabled_field?(field)
      chooser_preset[field].to_i == 1 rescue true
    end

    def state_preset
      Gaku::Preset.get('address_state')
    end

    def city_preset
      Gaku::Preset.get('address_city')
    end

    # def country_preset
    #   Gaku::Preset.get('address_country')
    # end

    def country_preset
      @country_preset ||= Gaku::Preset.get('country')
    end

    def gender_preset
      Gaku::Preset.get('students_gender')
    end

    def per_page_preset
      Preset.get('per_page')
    end

    def per_page_values
      [10, 25, 50, 100]
    end

  end
end
