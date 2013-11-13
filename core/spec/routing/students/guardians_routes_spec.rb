require 'spec_helper_routing'

describe Gaku::Students::GuardiansController do

  routes { Gaku::Core::Engine.routes }

  describe 'member' do

    it 'routes to #soft_delete' do
      expect(patch: '/students/1/guardians/1/soft_delete').to route_to(
        controller: 'gaku/students/guardians',
        action: 'soft_delete',
        student_id: '1',
        id: '1'
      )
    end

    it 'routes to #recovery' do
      expect(patch: '/students/1/guardians/1/recovery').to route_to(
        controller: 'gaku/students/guardians',
        action: 'recovery',
        student_id: '1',
        id: '1'
      )
    end

    it 'routes to #edit' do
      expect(get: '/students/1/guardians/1/edit').to route_to(
        controller: 'gaku/students/guardians',
        action: 'edit',
        student_id: '1',
        id: '1'
      )
    end

    it 'routes to #destroy' do
      expect(delete: '/students/1/guardians/1').to route_to(
        controller: 'gaku/students/guardians',
        action: 'destroy',
        student_id: '1',
        id: '1'
      )
    end

    it 'routes to #update' do
      expect(patch: '/students/1/guardians/1').to route_to(
        controller: 'gaku/students/guardians',
        action: 'update',
        student_id: '1',
        id: '1'
      )
    end
  end

  describe 'collection' do
    it 'routes to #new' do
      expect(get: '/students/1/guardians/new').to route_to(
        controller: 'gaku/students/guardians',
        action: 'new',
        student_id: '1'
      )
    end

    it 'routes to #create' do
      expect(post: '/students/1/guardians').to route_to(
        controller: 'gaku/students/guardians',
        action: 'create',
        student_id: '1'
      )
    end
  end

end