require 'spec_helper_routing'

describe Gaku::StudentsController do

  routes { Gaku::Core::Engine.routes }

  describe 'member' do

    it 'routes to #show' do
      expect(get: '/students/1').to route_to(
        controller: 'gaku/students',
        action: 'show',
        id: '1'
      )
    end

    it 'routes to #destroy' do
      expect(delete: '/students/1').to route_to(
        controller: 'gaku/students',
        action: 'destroy',
        id: '1'
      )
    end
  end

  describe 'collection' do

    it 'routes to #new' do
      expect(get: '/students/new').to route_to(
        controller: 'gaku/students',
        action: 'new'
      )
    end

    it 'routes to #create' do
      expect(post: '/students').to route_to(
        controller: 'gaku/students',
        action: 'create'
      )
    end

  end

end