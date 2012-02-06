module CoursesHelper
  def link_to_enroll_student(name, f)
    link_to name, {:controller => :course_enrollments, :action => :new}, :remote => true, :id => "add_student_enrollment"
  end
end
