require 'spec_helper_routing'

describe Gaku::Students::CourseEnrollmentsController do

  routes { Gaku::Core::Engine.routes }

  describe 'member' do
    it 'routes to #destroy' do
      expect(delete: '/students/1/course_enrollments/1').to route_to(
        controller: 'gaku/students/course_enrollments',
        action: 'destroy',
        student_id: '1',
        id: '1'
      )
    end
  end

  describe 'collection' do
    it 'routes to #new' do
      expect(get: '/students/1/course_enrollments/new').to route_to(
        controller: 'gaku/students/course_enrollments',
        action: 'new',
        student_id: '1'
      )
    end

    it 'routes to #create' do
      expect(post: '/students/1/course_enrollments').to route_to(
        controller: 'gaku/students/course_enrollments',
        action: 'create',
        student_id: '1'
      )
    end
  end

end