require 'spec_helper_routing'

describe Gaku::StudentsController do

  routes { Gaku::Core::Engine.routes }

  describe 'member' do
    it 'routes to #soft_delete' do
      expect(patch: '/students/1/soft_delete').to route_to(
        controller: 'gaku/students',
        action: 'soft_delete',
        id: '1'
      )
    end

    it 'routes to #recovery' do
      expect(patch: '/students/1/recovery').to route_to(
        controller: 'gaku/students',
        action: 'recovery',
        id: '1'
      )
    end

  end

end
