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
      if num == 2
        size = 62
      elsif num == 3
        size = 90
      end
      content_tag :th, class:"btn-info", style:"width:#{size}px" do
        t('manage')
      end
    end

  end
end
