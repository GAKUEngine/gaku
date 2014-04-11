require 'spec_helper_routing'

describe Gaku::Admin::Campuses::AddressesController do

  routes { Gaku::Core::Engine.routes }

  describe 'member' do
    it 'routes to #edit' do
      expect(get: 'admin/campuses/1/addresses/1/edit').to route_to(
        controller: 'gaku/admin/campuses/addresses',
        action: 'edit',
        campus_id: '1',
        id: '1'
      )
    end

    it 'routes to #update' do
      expect(patch: 'admin/campuses/1/addresses/1').to route_to(
        controller: 'gaku/admin/campuses/addresses',
        action: 'update',
        campus_id: '1',
        id: '1'
      )
    end

    it 'routes to #destroy' do
      expect(delete: 'admin/campuses/1/addresses/1').to route_to(
        controller: 'gaku/admin/campuses/addresses',
        action: 'destroy',
        campus_id: '1',
        id: '1'
      )
    end
  end

  describe 'collection' do

    it 'routes to #new' do
      expect(get: 'admin/campuses/1/addresses/new').to route_to(
        controller: 'gaku/admin/campuses/addresses',
        action: 'new',
        campus_id: '1'
      )
    end

    it 'routes to #create' do
      expect(post: 'admin/campuses/1/addresses').to route_to(
        controller: 'gaku/admin/campuses/addresses',
        action: 'create',
        campus_id: '1'
      )
    end

  end

end