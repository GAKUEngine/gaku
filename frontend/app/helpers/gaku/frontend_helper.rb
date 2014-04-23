module Gaku
  module FrontendHelper

    include Gaku::AutocompleteHelper
    include Gaku::ExamHelper
    include Gaku::PersonHelper
    include Gaku::SharedHelper
    include Gaku::StudentChooserHelper
    include Gaku::StudentsHelper

    def badge_count(count, text, css_class)
      if count != 0
        "#{text}<span class='badge pull-right #{css_class}'>#{count.to_s}</span>".html_safe
      else
        "#{text}<span class='badge pull-right #{css_class}'></span>".html_safe
      end
    end

    def ajax_link_to_search(text, resource, options = {})
      name = ("<span class='glyphicon glyphicon-search'></span> " + text).html_safe
      attributes = {
        :remote => true,
        :class => "btn btn-primary"
      }.merge(options)
      link_to name, resource, attributes
    end

    def prepare_target(nested_resource, address)
      return nil if nested_resource.blank?
      [nested_resource, address].flatten
    end


    def show_field?(field)
      ActiveRecord::ConnectionAdapters::Column.value_to_boolean(field.to_i)
    end


    def prepare_resource_name(nested_resources, resource)
      @resource_name = [nested_resources.map {|r| r.is_a?(Symbol) ? r.to_s : get_class(r) }, resource.to_s].flatten.join '-'
    end

    def extract_grouped(grouped, resource)
      grouped.map(&resource.to_sym)
    end

    def sort_handler
      content_tag :td, class: 'sort-handler' do
        content_tag :i, nil, class: 'glyphicon glyphicon-move'
      end
    end

    def sortable_tbody(path, &block)
      content_tag(:tbody, class: 'sortable', data: { 'sort-url' => url_for(path) }) do
        block.call
      end
    end


  end
end
