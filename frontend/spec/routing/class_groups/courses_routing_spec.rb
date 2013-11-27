require 'spec_helper_routing'

describe Gaku::ClassGroups::CoursesController do

  routes { Gaku::Core::Engine.routes }

  describe 'member' do

    it 'routes to #destroy' do
      expect(delete: 'class_groups/1/class_group_course_enrollments/1').to route_to(
        controller: 'gaku/class_groups/courses',
        action: 'destroy',
        class_group_id: '1',
        id: '1'
      )
    end
  end

  describe 'collection' do

    it 'routes to #new' do
      expect(get: 'class_groups/1/class_group_course_enrollments/new').to route_to(
        controller: 'gaku/class_groups/courses',
        action: 'new',
        class_group_id: '1'
      )
    end

    it 'routes to #create' do
      expect(post: 'class_groups/1/class_group_course_enrollments').to route_to(
        controller: 'gaku/class_groups/courses',
        action: 'create',
        class_group_id: '1'
      )
    end


  end

end