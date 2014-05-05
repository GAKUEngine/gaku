require 'spec_helper_routing'

describe Gaku::TeachersController do

  routes { Gaku::Core::Engine.routes }

  describe 'member' do

    it 'routes to #set_picture' do
      expect(patch: '/teachers/1/set_picture').to route_to(
        controller: 'gaku/teachers',
        action: 'set_picture',
        id: '1'
      )
    end

    it 'routes to #remove_picture' do
      expect(delete: '/teachers/1/remove_picture').to route_to(
        controller: 'gaku/teachers',
        action: 'remove_picture',
        id: '1'
      )
    end

    it 'routes to #show' do
      expect(get: '/teachers/1').to route_to(
        controller: 'gaku/teachers',
        action: 'show',
        id: '1'
      )
    end

    it 'routes to #show' do
      expect(get: '/teachers/1/edit').to route_to(
        controller: 'gaku/teachers',
        action: 'edit',
        id: '1'
      )
    end

    it 'routes to #destroy' do
      expect(delete: '/teachers/1').to route_to(
        controller: 'gaku/teachers',
        action: 'destroy',
        id: '1'
      )
    end
  end

  describe 'collection' do

    it 'routes to #new' do
      expect(get: '/teachers/new').to route_to(
        controller: 'gaku/teachers',
        action: 'new'
      )
    end

    it 'routes to #index' do
      expect(get: '/teachers').to route_to(
        controller: 'gaku/teachers',
        action: 'index'
      )
    end

    it 'routes to #create' do
      expect(post: '/teachers').to route_to(
        controller: 'gaku/teachers',
        action: 'create'
      )
    end

  end

end
