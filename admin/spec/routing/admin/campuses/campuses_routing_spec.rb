require 'spec_helper_routing'

describe Gaku::Admin::CampusesController do

  routes { Gaku::Core::Engine.routes }

  describe 'member' do
    it 'routes to #show' do
      expect(get: 'admin/schools/1/campuses/1').to route_to(
        controller: 'gaku/admin/campuses',
        action: 'show',
        school_id: '1',
        id: '1'
      )
    end

    it 'routes to #edit' do
      expect(get: 'admin/schools/1/campuses/1/edit').to route_to(
        controller: 'gaku/admin/campuses',
        action: 'edit',
        school_id: '1',
        id: '1'
      )
    end

    it 'routes to #update' do
      expect(patch: 'admin/schools/1/campuses/1').to route_to(
        controller: 'gaku/admin/campuses',
        action: 'update',
        school_id: '1',
        id: '1'
      )
    end

    it 'routes to #destroy' do
      expect(delete: 'admin/schools/1/campuses/1').to route_to(
        controller: 'gaku/admin/campuses',
        action: 'destroy',
        school_id: '1',
        id: '1'
      )
    end
  end

  describe 'collection' do

    it 'routes to #new' do
      expect(get: 'admin/schools/1/campuses/new').to route_to(
        controller: 'gaku/admin/campuses',
        action: 'new',
        school_id: '1'
      )
    end

    it 'routes to #create' do
      expect(post: 'admin/schools/1/campuses').to route_to(
        controller: 'gaku/admin/campuses',
        action: 'create',
        school_id: '1'
      )
    end

  end

end