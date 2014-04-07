require 'spec_helper_routing'

describe Gaku::GuardiansController do

  routes { Gaku::Core::Engine.routes }

  describe 'member' do

    it 'routes to #edit' do
      expect(get: '/students/1/guardians/1/edit').to route_to(
        controller: 'gaku/guardians',
        action: 'edit',
        student_id: '1',
        id: '1'
      )
    end

    it 'routes to #destroy' do
      expect(delete: '/students/1/guardians/1').to route_to(
        controller: 'gaku/guardians',
        action: 'destroy',
        student_id: '1',
        id: '1'
      )
    end

    it 'routes to #update' do
      expect(patch: '/students/1/guardians/1').to route_to(
        controller: 'gaku/guardians',
        action: 'update',
        student_id: '1',
        id: '1'
      )
    end
  end

  describe 'collection' do
    it 'routes to #new' do
      expect(get: '/students/1/guardians/new').to route_to(
        controller: 'gaku/guardians',
        action: 'new',
        student_id: '1'
      )
    end

    it 'routes to #create' do
      expect(post: '/students/1/guardians').to route_to(
        controller: 'gaku/guardians',
        action: 'create',
        student_id: '1'
      )
    end
  end

end