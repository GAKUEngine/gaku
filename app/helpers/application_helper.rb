module ApplicationHelper
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(("<i class='icon-plus icon-white'></i> "+name).html_safe, '#', :class => "btn btn-primary add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def sortable(column, title = nil)
  	direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
  	css_class = column == sort_column ? "current #{sort_direction}" : nil
  	link_to title, {:sort => column, :direction => direction}, {:class => css_class, :remote => true}
  end

  def student_sortable(column, title = nil)
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

end
