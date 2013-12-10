module Gaku::FlashHelper

  def flash_color(type)
    case type
      when :notice then 'alert alert-info'
      when :success then 'alert alert-success'
      when :error then 'alert alert-danger'
      when :alert then 'alert alert-danger'
    end
  end

  def render_flash
    escape_javascript(render 'gaku/shared/flash', flash: flash)
  end

end