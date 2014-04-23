require 'spec_helper_routing'

describe Gaku::Admin::TemplatesController do

  routes { Gaku::Core::Engine.routes }

  describe 'member' do

    it 'routes to #edit' do
      expect(get: 'admin/templates/1/edit').to route_to(
        controller: 'gaku/admin/templates',
        action: 'edit',
        id: '1'
      )
    end

    it 'routes to #download' do
      expect(get: 'admin/templates/1/download').to route_to(
        controller: 'gaku/admin/templates',
        action: 'download',
        id: '1'
      )
    end

    it 'routes to #destroy' do
      expect(delete: 'admin/templates/1').to route_to(
        controller: 'gaku/admin/templates',
        action: 'destroy',
        id: '1'
      )
    end
  end

  describe 'collection' do

    it 'routes to #index' do
      expect(get: 'admin/templates/').to route_to(
        controller: 'gaku/admin/templates',
        action: 'index'
      )
    end

    it 'routes to #new' do
      expect(get: 'admin/templates/new').to route_to(
        controller: 'gaku/admin/templates',
        action: 'new'
      )
    end

    it 'routes to #create' do
      expect(post: 'admin/templates').to route_to(
        controller: 'gaku/admin/templates',
        action: 'create'
      )
    end

  end

end
