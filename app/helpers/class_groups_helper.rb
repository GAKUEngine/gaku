module ClassGroupsHelper
  def link_to_enroll_student(name, class_group_num, f)
    link_to name, {:controller => :class_group_enrollments, :action => :new, :format => :html, :active => "class_group", :idnum => class_group_num}, :remote => true, :id => f
  end
end
