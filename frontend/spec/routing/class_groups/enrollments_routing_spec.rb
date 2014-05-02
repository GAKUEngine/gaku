require 'spec_helper_routing'

describe Gaku::EnrollmentsController do

  routes { Gaku::Core::Engine.routes }

  describe 'member' do

    it 'routes to #destroy' do
      expect(delete: '/class_groups/1/enrollments/1/').to route_to(
        controller: 'gaku/enrollments',
        action: 'destroy',
        class_group_id: '1',
        id: '1'
      )
    end
  end

  describe 'collection' do

    it 'routes to #student_selection' do
      expect(get: '/class_groups/1/enrollments/student_selection').to route_to(
        controller: 'gaku/enrollments',
        action: 'student_selection',
        class_group_id: '1'
      )
    end

    it 'routes to #create_from_selection' do
      expect(post: '/class_groups/1/enrollments/create_from_selection').to route_to(
        controller: 'gaku/enrollments',
        action: 'create_from_selection',
        class_group_id: '1'
      )
    end

    it 'routes to #new' do
      expect(get: '/class_groups/1/enrollments/new').to route_to(
        controller: 'gaku/enrollments',
        action: 'new',
        class_group_id: '1'
      )
    end

    it 'routes to #create' do
      expect(post: '/class_groups/1/enrollments').to route_to(
        controller: 'gaku/enrollments',
        action: 'create',
        class_group_id: '1'
      )
    end

  end

end