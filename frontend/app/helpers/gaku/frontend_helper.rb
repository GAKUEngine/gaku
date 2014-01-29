module Gaku
  module FrontendHelper

    include Gaku::AutocompleteHelper
    include Gaku::ExamHelper
    include Gaku::PersonHelper
    include Gaku::SharedHelper
    include Gaku::StudentChooserHelper
    include Gaku::StudentsHelper


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


    def prepare_resource_name(nested_resources, resource)
      @resource_name = [nested_resources.map {|r| r.is_a?(Symbol) ? r.to_s : get_class(r) }, resource.to_s].flatten.join '-'
    end

    def extract_grouped(grouped, resource)
      grouped.map(&resource.to_sym)
    end


  end
end