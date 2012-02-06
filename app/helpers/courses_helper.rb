module CoursesHelper
  def link_to_enroll_student(name, coursenum, f)
    link_to name, {:controller => :course_enrollments, :action => :new, :format => :html, :active => "course", :idnum => coursenum}, :remote => true, :id => f
  end
end
