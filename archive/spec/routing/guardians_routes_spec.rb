require 'spec_helper_routing'

describe Gaku::GuardiansController do

  routes { Gaku::Core::Engine.routes }

  describe 'member' do

    it 'routes to #soft_delete' do
      expect(patch: '/students/1/guardians/1/soft_delete').to route_to(
        controller: 'gaku/guardians',
        action: 'soft_delete',
        student_id: '1',
        id: '1'
      )
    end

    it 'routes to #recovery' do
      expect(patch: '/students/1/guardians/1/recovery').to route_to(
        controller: 'gaku/guardians',
        action: 'recovery',
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

  end
end
