module Gaku
  module SharedHelper

    def can_edit?
      action_name.include? 'edit'
    end

    def genders
      { t(:'gender.female') => false, t(:'gender.male') => true }
    end

    def state_load(object)
      object.country.nil? ? Gaku::State.none : object.country.states
    end

    def disabled?(object)
      object.new_record? || object.country.states.blank?
    end

    def render_flash
      escape_javascript(render 'gaku/shared/flash', flash: flash)
    end

  end
end
