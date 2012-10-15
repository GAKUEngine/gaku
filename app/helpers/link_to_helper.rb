module LinkToHelper

	def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(("<i class='icon-plus icon-white'></i> "+name).html_safe, '#', :class => "btn btn-primary add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def button(text, resource, options = {})
    attributes = {
      :class => "btn btn-primary"
    }.merge(options)
    link_to text, resource, attributes
  end

  def link_to_file(text, resource, options = {})
    name = ("<i class='icon-white icon-file'></i>" + text).html_safe
    attributes = {
      :class => "btn btn-primary"
    }.merge(options)
    link_to name, resource, attributes
  end

  #needs id, because it is unique
  def ajax_link_to_new(text, resource, options = {})
    name = ("<i class='icon-white icon-plus'></i> " + text).html_safe
    attributes = {
      :remote => true,
      :class => "btn btn-primary"
    }.merge(options)
    link_to name, resource, attributes
  end

  #needs id
  def link_to_new(text, resource, options = {})
    name = ("<i class='icon-white icon-plus'></i> " + text).html_safe
    attributes = {
      :class => "btn btn-primary"
    }.merge(options)
    link_to name, resource, attributes
  end

  #needs id
  def submit_button(text, options={})
    attributes = {
      :type => 'submit'
    }.merge(options)
    button_tag(content_tag('span', text), attributes)
  end

  def ajax_link_to_delete(resource, options = {})
    name = ("<i class='icon-white icon-remove'></i>").html_safe
    attributes = {
      :remote => true,
      :method => :delete,
      :data => { :confirm => 'Are you sure?' },
      :class => 'btn btn-mini btn-danger delete-link'
    }.merge(options)
    link_to name, resource, attributes
  end

  def ajax_link_to_make_primary(resource, options = {})
    name = ("<i class='icon-white icon-ok'></i>").html_safe
    attributes = {
      :remote => true,
      :method => :post,
      :data => { :confirm => 'Are you sure?' },
    }.merge(options)
    link_to name, resource, attributes
  end

  def ajax_link_to_edit(resource, options = {})
    name = ("<i class='icon-white icon-pencil'></i>").html_safe
    attributes = {
      :remote => true,
      :class => "mr-xs btn btn-mini btn-warning edit-link"
    }.merge(options)
    link_to name, resource, attributes
  end
  

  # Edit button with only pencil image - without text
  def link_to_edit(resource, options = {})
    name = ("<i class='icon-white icon-pencil'></i>").html_safe
    attributes = {
      :class => "mr-xs btn btn-mini btn-warning edit-link"
    }.merge(options)
    link_to name, resource, attributes
  end   

  # Edit button with text "Edit" and pencil image
  def link_to_edit_with_text(resource, options = {})
    name = ('<i class="icon-white icon-pencil"></i> '+t(:Edit)).html_safe
    attributes = {
      :class => "edit-link"
    }.merge(options)
    link_to name, resource, attributes
  end  

  def link_to_show(resource, options = {})
    name = ("<i class='icon-white icon-eye-open'></i>").html_safe
    attributes = {
      :class => "mr-xs btn btn-mini btn-success show-link"
    }.merge(options)
    link_to name, resource, attributes
  end   

  def link_to_cancel(options = {})
    name = t('.cancel', :default => t("helpers.links.cancel"))
    attributes = {
      :class => "span3 btn btn-danger",
      :'data-dismiss' => "modal"
    }.merge(options)
    link_to name, '#', attributes
  end 

  def link_to_back(resource, options = {})
    name = ('<i class="icon-white icon-share-alt"></i> '+t(:Back)).html_safe
    link_to name, resource, options
  end   

  def submit_button(text, options={})
    attributes = {
      :type => 'submit',
      :class => 'span12 btn btn-primary button'
    }.merge(options)
    button_tag(content_tag('span', text), attributes)
  end

end