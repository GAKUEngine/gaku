require 'spec_helper_routing'

describe Gaku::Admin::Schools::Campuses::ContactsController  do

  routes { Gaku::Core::Engine.routes }

  describe 'member' do
    it 'routes to #edit' do
      expect(get: 'admin/schools/1/campuses/1/contacts/1/edit').to route_to(
        controller: 'gaku/admin/schools/campuses/contacts',
        action: 'edit',
        school_id: '1',
        campus_id: '1',
        id: '1'
      )
    end

    it 'routes to #update' do
      expect(patch: 'admin/schools/1/campuses/1/contacts/1').to route_to(
        controller: 'gaku/admin/schools/campuses/contacts',
        action: 'update',
        school_id: '1',
        campus_id: '1',
        id: '1'
      )
    end

    it 'routes to #destroy' do
      expect(delete: 'admin/schools/1/campuses/1/contacts/1').to route_to(
        controller: 'gaku/admin/schools/campuses/contacts',
        action: 'destroy',
        school_id: '1',
        campus_id: '1',
        id: '1'
      )
    end
  end

  describe 'collection' do

    it 'routes to #new' do
      expect(get: 'admin/schools/1/campuses/1/contacts/new').to route_to(
        controller: 'gaku/admin/schools/campuses/contacts',
        action: 'new',
        school_id: '1',
        campus_id: '1'
      )
    end

    it 'routes to #create' do
      expect(post: 'admin/schools/1/campuses/1/contacts').to route_to(
        controller: 'gaku/admin/schools/campuses/contacts',
        action: 'create',
        school_id: '1',
        campus_id: '1'
      )
    end

  end

end