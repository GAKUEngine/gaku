module Gaku
  module SharedHelper

    def can_edit?
      if controller.action_name.include?('edit')
        true
      else
        false
      end
    end

    def cannot_edit?
      ! can_edit?
    end

    def genders
      { t(:'gender.female') => false, t(:'gender.male') => true }
    end

    def render_js_partial(partial, locals = {})
      unless locals == {}
        escape_javascript(render partial: partial, formats: [:html], handlers: [:erb, :slim], locals: locals)
      else
        escape_javascript(render partial: partial, formats: [:html], handlers: [:erb, :slim])
      end
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