module Gaku
  module PresetsHelper

    def state_preset
      Gaku::Preset.get('address_state')
    end

    def city_preset
      Gaku::Preset.get('address_city')
    end

    def country_preset
      Gaku::Preset.get('address_country')
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
