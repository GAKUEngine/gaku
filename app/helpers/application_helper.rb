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

  def sortable(column, title = nil)
  	direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
  	css_class = column == sort_column ? "current #{sort_direction}" : nil
  	link_to title, {:sort => column, :direction => direction}, {:class => css_class, :remote => true}
  end

  def student_sortable(column, title = nil)
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end

  def flash_color(type)
    case type
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :error then "alert alert-error"
      when :alert then "alert alert-error" 
    end 
  end

  def render_flash
    escape_javascript(render 'shared/flash', :flash => flash)
  end

  def title(text)
    content_for(:title) do 
      text
    end
  end

end

