module ApplicationHelper

  include LinkToHelper
  include SortHelper

  def print_count(count, text)
    count != 0 ? text + "(" + count.to_s + ")" : text
  end

  def render_js_partial(partial, locals = {})
    unless locals == {}
      escape_javascript(render :partial => partial, :formats => [:html], :handlers => [:erb, :slim], :locals => locals) 
    else
      escape_javascript(render :partial => partial, :formats => [:html], :handlers => [:erb, :slim]) 
    end
  end

end