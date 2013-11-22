require 'spec_helper_routing'

describe Gaku::ClassGroups::StudentsController do

  routes { Gaku::Core::Engine.routes }

  describe 'member' do

    it 'routes to #destroy' do
      expect(delete: 'class_groups/1/students/1').to route_to(
        controller: 'gaku/class_groups/students',
        action: 'destroy',
        class_group_id: '1',
        id: '1'
      )
    end
  end

  describe 'collection' do

    it 'routes to #new' do
      expect(get: 'class_groups/1/students/new').to route_to(
        controller: 'gaku/class_groups/students',
        action: 'new',
        class_group_id: '1'
      )
    end

    it 'routes to #enroll_student' do
      expect(post: 'class_groups/1/students/enroll_student').to route_to(
        controller: 'gaku/class_groups/students',
        action: 'enroll_student',
        class_group_id: '1'
      )
    end


  end

end