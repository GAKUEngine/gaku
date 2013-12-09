module Gaku
  module PresetsHelper

    def preset_checked?(field)
      chooser_preset ||= Gaku::Preset.active.chooser_fields
      chooser_preset[field.to_s].to_i == 1 rescue true
    end

  end
end
