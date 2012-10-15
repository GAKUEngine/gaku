module SortHelper

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
  
end