module Gaku
  module GakuHelper

    include LinkToHelper
    include SortHelper
    include TranslationsHelper

    def present(object, klass = nil)
      klass ||= "#{object.class}Presenter".constantize
      puts klass
      presenter = klass.new(object, self)
      yield presenter if block_given?
      presenter
    end

    def remote_form_for(object, options = {}, &block)
      options[:validate] = true
      #options[:builder] = ValidateFormBuilder
      options[:html] = {:class => 'remote-form'}
      options[:remote] = true
      form_for(object, options, &block)
    end


    def required_field
      ('<span class= "label label-important pull-right">' + t(:required) + '</span>').html_safe
    end

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
      escape_javascript(render 'gaku/shared/flash', :flash => flash)
    end

    def title(text)
      content_for(:title) do
        text
      end
    end

    def boolean_image(field)
      if field
        image_tag('tick.png')
      else
        image_tag('cross.png')
      end
    end

    def color_code(color)
      "<div style='width:100px;height:20px;background-color:#{color};border:1px solid whitesmoke'></div> ".html_safe
    end

  end
end

