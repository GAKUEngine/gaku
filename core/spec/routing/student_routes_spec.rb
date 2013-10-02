require 'spec_helper'

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

    it 'routes to #show_deleted' do
      expect(get: '/students/1/show_deleted').to route_to(
        controller: 'gaku/students',
        action: 'show_deleted',
        id: '1'
      )
    end

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

    it 'routes to #load_autocomplete_data' do
      expect(get: '/students/load_autocomplete_data').to route_to(
        controller: 'gaku/students',
        action: 'load_autocomplete_data'
      )
    end
  end

end