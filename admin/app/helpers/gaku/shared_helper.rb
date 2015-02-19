module Gaku
  module SharedHelper

    def can_edit?
      %w( edit create update ).include? action_name
    end

    def genders
      { t(:'gender.female') => false, t(:'gender.male') => true }
    end

    def state_load(country_preset)
      country = Gaku::Country.find_by(iso: country_preset)
      if country
        country.states
      else
        Gaku::State.none
      end
    end

    def disabled?(country_preset)
      country = Gaku::Country.find_by(iso: country_preset)
      if country
        country.states_required
      else
        true
      end
    end

    def render_flash
      escape_javascript(render 'gaku/shared/flash', flash: flash)
    end

  end
end
