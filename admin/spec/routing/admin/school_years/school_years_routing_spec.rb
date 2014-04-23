require 'spec_helper_routing'

describe Gaku::Admin::SchoolYearsController do

  routes { Gaku::Core::Engine.routes }

  describe 'member' do

    it 'routes to #edit' do
      expect(get: 'admin/school_years/1/edit').to route_to(
        controller: 'gaku/admin/school_years',
        action: 'edit',
        id: '1'
      )
    end

    it 'routes to #show' do
      expect(get: 'admin/school_years/1').to route_to(
        controller: 'gaku/admin/school_years',
        action: 'show',
        id: '1'
      )
    end

    it 'routes to #update' do
      expect(patch: 'admin/school_years/1').to route_to(
        controller: 'gaku/admin/school_years',
        action: 'update',
        id: '1'
      )
    end

    it 'routes to #destroy' do
      expect(delete: 'admin/school_years/1').to route_to(
        controller: 'gaku/admin/school_years',
        action: 'destroy',
        id: '1'
      )
    end
  end

  describe 'collection' do

    it 'routes to #index' do
      expect(get: 'admin/school_years/').to route_to(
        controller: 'gaku/admin/school_years',
        action: 'index'
      )
    end

    it 'routes to #new' do
      expect(get: 'admin/school_years/new').to route_to(
        controller: 'gaku/admin/school_years',
        action: 'new'
      )
    end

    it 'routes to #create' do
      expect(post: 'admin/school_years').to route_to(
        controller: 'gaku/admin/school_years',
        action: 'create'
      )
    end

  end

end
