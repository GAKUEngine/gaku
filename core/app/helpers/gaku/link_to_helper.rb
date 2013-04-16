module Gaku
  module LinkToHelper

  	def link_to_add_fields(name, f, association)
      new_object = f.object.send(association).klass.new
      id = new_object.object_id
      fields = f.fields_for(association, new_object, child_index: id) do |builder|
        render(association.to_s.singularize + "_fields", f: builder)
      end
      link_to(("<i class='icon-plus icon-white'></i> " + name).html_safe, '#', :class => "btn btn-primary add_fields", data: {id: id, fields: fields.gsub("\n", "")})
    end

    def button(text, resource, options = {})
      attributes = {
        :class => "btn mr-s"
      }.merge(options)
      link_to text, resource, attributes
    end

    def primary_button(text, resource, options = {})
      attributes = {
        :class => "btn btn-primary mr-s"
      }.merge(options)
      link_to text, resource, attributes
    end

    def link_to_file(text, resource, options = {})
      name = ("<i class='icon-white icon-file'></i> " + text).html_safe
      attributes = {
        :class => "btn btn-primary"
      }.merge(options)
      link_to name, resource, attributes
    end

    def link_to_upload_image(resource, options = {})
      name = ("<i class='icon-camera'></i> " + t(:'pictures.change')).html_safe
      attributes = {
        :class => "btn span12 mr-s"
      }.merge(options)
      link_to name, resource, attributes
    end

    def link_to_upload(options = {})
      text = ("<i class='icon-upload'></i> " + t(:'pictures.upload')).html_safe
      attributes = {
        :class => "btn span12 mr-s"
      }.merge(options)
      button_tag(content_tag('span', text), attributes)
    end

    def link_to_import(text, resource, options = {})
      name = ('<i class="icon-upload"></i> '+ text).html_safe
      attributes = {
        :class => 'mr-s btn'
      }.merge(options)
      link_to name, resource, attributes
    end

    def link_to_export(text, resource, options = {})
      name = ('<i class="icon-download"></i> '+ text).html_safe
      attributes = {
        :class => 'mr-s btn'
      }.merge(options)
      link_to name, resource, attributes
    end

    #needs id, because it is unique
    def ajax_link_to_new(text, resource, options = {})
      name = ("<i class='icon-white icon-plus'></i> " + text).html_safe
      attributes = {
        :remote => true,
        :class => "btn btn-primary mr-s"
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

    def ajax_link_to_recovery(resource, options = {})
      name = content_tag(:i, nil, :class => 'icon-white icon-repeat')
      attributes = {
        :remote => true,
        :class => "mr-xs btn btn-mini btn-warning recovery-link"
      }.merge(options)
      link_to name, resource, attributes
    end

    def ajax_link_to_delete(resource, options = {})
      name = ("<i class='icon-white icon-remove'></i>").html_safe
      attributes = {
        :remote => true,
        :method => :delete,
        :data => { :confirm => t(:are_you_sure) },
        :class => 'btn btn-mini btn-danger delete-link'
      }.merge(options)
      link_to name, resource, attributes
    end

    def link_to_modal_delete(resource, options = {})
      name = ("<i class='icon-white icon-trash'></i>").html_safe
      attributes = {
        :class => 'btn btn-danger modal-delete-link span12'
      }.merge(options)
      link_to name, resource, attributes
    end

    def ajax_soft_delete(resource, options = {})
      name = ("<i class='icon-white icon-remove'></i>").html_safe
      attributes = {
        :remote => true,
        # :method => :post,
        :data => { :confirm => t(:are_you_sure) },
        :class => 'btn btn-mini btn-danger delete-link'
      }.merge(options)
      link_to name, resource, attributes
    end


    def primary_checkbox
      ("<i class='icon-white icon-ok'></i>").html_safe
    end

    def ajax_link_to_make_primary(resource, options = {})
      attributes = {
        :remote => true,
        :method => :post,
        :data => { :confirm => t(:are_you_sure) },
      }.merge(options)
      link_to primary_checkbox, resource, attributes
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
      name = ("<i class='icon-white icon-edit'></i>").html_safe
      attributes = {
        :class => "mr-xs btn btn-mini btn-inverse edit-link",
      }.merge(options)
      link_to name, resource, attributes
    end

    # Edit button with text "Edit" and pencil image
    def link_to_edit_with_text(resource, options = {})
      name = ('<i class="icon-pencil"></i> '+t(:edit)).html_safe
      attributes = {
        :class => "span12 btn edit-link"
      }.merge(options)
      link_to name, resource, attributes
    end

    def link_to_edit_with_custom_text(text, resource, options = {})
      name = ('<i class="icon-pencil"></i> '+ text).html_safe
      attributes = {
        :class => "span12 btn edit-link"
      }.merge(options)
      link_to name, resource, attributes
    end

    def ajax_link_to_show(resource, options = {})
      name = ("<i class='icon-white icon-eye-open'></i>").html_safe
      attributes = {
        :remote => true,
        :class => "mr-xs btn btn-mini btn-info show-link"
      }.merge(options)
      link_to name, resource, attributes
    end

    def link_to_show(resource, options = {})
      name = ("<i class='icon-white icon-eye-open'></i>").html_safe
      attributes = {
        :class => "mr-xs btn btn-mini btn-info show-link"
      }.merge(options)
      link_to name, resource, attributes
    end

    def link_to_cancel(options = {})
      text = ('<i class="icon-white icon-ban-circle"></i> '+ t(:'cancel')).html_safe
      attributes = {
        :class => "span6 btn btn-warning cancel-link",
        :'data-dismiss' => "modal"
      }.merge(options)
      link_to text, '#', attributes
    end

    def link_to_modal_cancel(options = {})
      name = t('cancel')
      attributes = {
        :class => "span6 btn btn-warning cancel-link",
      }.merge(options)
      link_to name, '#', attributes
    end

    def ajax_link_to_back(resource, options = {})
      name = ('<i class="icon-white icon-share-alt"></i> '+t(:back)).html_safe
      attributes = {
        :class => "span6 btn btn-warning back-link back-modal-link",
        :remote => true
      }.merge(options)

      link_to name, resource, attributes
    end

    def link_to_back(resource, options = {})
      name = ('<i class="icon-share-alt"></i> '+ t(:back)).html_safe
      attributes = {
        :class => 'span6 btn back-link'
      }.merge(options)
      link_to name, resource, attributes
    end

    def submit_button(text, options={})
      text = ('<i class="icon-white icon-ok-circle"></i> '+ text).html_safe
      attributes = {
        :type => 'submit',
        :class => 'span6 btn btn-primary button'
      }.merge(options)
      button_tag(content_tag('span', text), attributes)
    end

  end
end
