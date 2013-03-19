module Gaku
  module HtmlHelper

    def table_for(id, &block)
      content_tag :div, class: "row-fluid" do
        content_tag :table, class: "table table-striped table-bordered table-condensed", id: id do
          block.call
        end
      end
    end

    def table(&block)
      content_tag :table, class: "table table-striped table-bordered table-condensed" do
        block.call
      end
    end


    def show_table_for(id, &block)
      content_tag :div, class: "row-fluid" do
        content_tag :table, class: "table table-hover  table-condensed", id: id do
          block.call
        end
      end
    end

    def show_table(&block)
      content_tag :table, class: "table table-hover table-condensed"  do
        block.call
      end
    end

    def hr
      content_tag :div, class: "row-fluid" do
        content_tag :div, class: "span12" do
          content_tag :hr
        end
      end
    end

    def well_div(&block)
      content_tag :div, class: "row-fluid" do
        content_tag :div, class: "span12 well" do
          block.call
        end
      end
    end

    def index_body(&block)
      content_tag :div, class: "row-fluid" do
        content_tag :div, class: "span12" do
          block.call
        end
      end
    end

    def index_header(&block)
      content_tag :div, class: "row-fluid" do
        block.call
      end
    end

    def sortable_table_for(id, &block)
      content_tag :table, class: "table table-striped table-bordered table-condensed tablesorter", id: id do
        block.call
      end
    end

    def th(text)
      content_tag(:th, class: "btn-inverse") { text }
    end

    def th_icon(icon)
      content_tag :th, class: "btn-inverse", style: "width:24px;" do
        content_tag :i, nil,  class: "icon-#{icon} icon-white"
      end
    end

    def th_actions(num)
      size = case num
      when 1 then 40
      when 2 then 62
      when 3 then 95
      else num
      end
      content_tag :th, class:"btn-info", style:"width:#{size}px" do
        t('manage')
      end
    end

    def manage_buttons_for(resource, options = {})
      id = extract_id(resource)
      concat link_to_show(resource, :id => "show-#{id}-link") unless except?(:show, options)
      concat link_to_edit [:edit] + [resource].flatten, :id => "edit-#{id}-link", :remote => true unless except?(:edit, options)
      ajax_link_to_delete resource, :id => "delete-#{id}-link" unless except?(:delete, options)
    end

    private

    def except?(button_symbol, options)
      [options[:except]].flatten.include?(button_symbol)
    end

    def extract_id(resource)
      if resource.kind_of?(Array)
        resource_id = String.new
        resource.each_with_index do |r, index|
          resource_id << '-' unless index == 0
          resource_id << proper_id(r)
        end
        resource_id
      else
        proper_id(resource)
      end
    end

    def proper_id(resource)
      resource.class.to_s.underscore.split('/')[1].dasherize
    end

  end
end
