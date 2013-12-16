module Gaku
  module SharedHelper

    def can_edit?
      %w( edit create ).include? controller.action_name
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

    def title(text)
      content_for(:title) do
        text
      end
    end

    def datepicker_date_format(date)
      date ?  date.strftime('%Y-%m-%d') : Time.now.strftime('%Y-%m-%d')
    end

    def state_load(object)
      object.country.nil? ? Gaku::State.none : object.country.states
    end

    def disabled?(object)
      object.new_record? || object.country.states.blank?
    end

  end
end