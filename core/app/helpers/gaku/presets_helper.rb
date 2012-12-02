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

  end
end
