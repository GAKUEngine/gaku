require 'spec_helper_routing'

describe Gaku::Admin::SchoolsController do

  routes { Gaku::Core::Engine.routes }

  describe 'member' do
    it 'routes to #show' do
      expect(get: 'admin/schools/1').to route_to(
        controller: 'gaku/admin/schools',
        action: 'show',
        id: '1'
      )
    end

    it 'routes to #edit' do
      expect(get: 'admin/schools/1/edit').to route_to(
        controller: 'gaku/admin/schools',
        action: 'edit',
        id: '1'
      )
    end

    it 'routes to #destroy' do
      expect(delete: 'admin/schools/1').to route_to(
        controller: 'gaku/admin/schools',
        action: 'destroy',
        id: '1'
      )
    end
  end

  describe 'collection' do

    it 'routes to #show_master' do
      expect(get: 'admin/school_details').to route_to(
        controller: 'gaku/admin/schools',
        action: 'show_master'
      )
    end

    it 'routes to #edit_master' do
      expect(get: 'admin/school_details/edit').to route_to(
        controller: 'gaku/admin/schools',
        action: 'edit_master'
      )
    end

    it 'routes to #update_master' do
      expect(patch: 'admin/school_details/update').to route_to(
        controller: 'gaku/admin/schools',
        action: 'update_master'
      )
    end

    it 'routes to #index' do
      expect(get: 'admin/schools/').to route_to(
        controller: 'gaku/admin/schools',
        action: 'index'
      )
    end

    it 'routes to #new' do
      expect(get: 'admin/schools/new').to route_to(
        controller: 'gaku/admin/schools',
        action: 'new'
      )
    end

    it 'routes to #create' do
      expect(post: 'admin/schools').to route_to(
        controller: 'gaku/admin/schools',
        action: 'create'
      )
    end

  end

end