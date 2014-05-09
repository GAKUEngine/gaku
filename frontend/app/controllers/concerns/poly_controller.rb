module PolyController

  private

  def parent_resource
    nested_resources.last
  end

  def nested_resources
    @nested_resources ||= Array.new.tap do |array|
      nested_resource_params.each do |param, value|
        array.append find_resource(param, value)
      end
    end
  end

  def resource_names
    Array.new.tap do |a|
      a.append nested_resource_names
      a.append polymorphic_resource_name
      a.prepend namespace if namespaced?
    end.join('-')

  end

  def nested_resource_params
    params.select { |param, _| param =~ /(.+)_id$/i }
  end

  def namespaced?
    controller_path.split('/').count == 3
  end

  def namespace
    controller_path.split('/')[1]
  end

  def find_resource(param, value)
    param.gsub('_id', '').prepend('gaku/').classify.constantize.find(value)
  end

  def nested_resource_names
    nested_resource_params.keys.map {|p| p.gsub('_id', '').dasherize }
  end

  def polymorphic_resource_name
    controller_name.singularize
  end
end
