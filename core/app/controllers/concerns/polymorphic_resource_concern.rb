module PolymorphicResourceConcern

  private

  def set_polymorphic_resource
    klasses = polymorphic_klasses.select do |c|
      params[c.to_s.foreign_key]
    end

    @nested_resources = nested_resources(klasses)
    #puts "Resource :::::::::::::::::::: #{resource_name}"
    @polymorphic_resource_name = resource_name
  end

  def nested_resources(klasses)
    nested_resources = []
    last_klass_foreign_key = params[klasses.last.to_s.foreign_key]
    if klasses.is_a? Array
      @polymorphic_resource = klasses.last.find(last_klass_foreign_key)
      klasses.pop #remove @polymorphic_resource resource
      klasses.each do |klass|
        nested_resources.append klass.find(params[klass.to_s.foreign_key])
      end
    else
      @polymorphic_resource = klasses.find(params[klasses.to_s.foreign_key])
    end

    #prepend :admin for admin/namespacing
    nested_resources.prepend(:admin) if @polymorphic_resource.class == Gaku::Campus
    nested_resources
  end

  def resource_name
    resource_name = []
    @nested_resources.each do |resource|
      if resource.is_a?(Symbol)
        resource_name.append(resource.to_s)
      else
        resource_name.append(get_class(resource))
      end
    end
    resource_name.append get_class(@polymorphic_resource)
    resource_name.append resource_klass
    resource_name.join '-'
  end

end