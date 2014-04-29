require 'spec_helper_routing'

describe Gaku::Students::ExternalSchoolRecordsController do

  routes { Gaku::Core::Engine.routes }

  describe 'member' do
    it 'routes to #edit' do
      expect(get: '/students/1/external_school_records/1/edit').to route_to(
        controller: 'gaku/students/external_school_records',
        action: 'edit',
        student_id: '1',
        id: '1'
      )
    end

    it 'routes to #destroy' do
      expect(delete: '/students/1/external_school_records/1').to route_to(
        controller: 'gaku/students/external_school_records',
        action: 'destroy',
        student_id: '1',
        id: '1'
      )
    end

    it 'routes to #update' do
      expect(patch: '/students/1/external_school_records/1').to route_to(
        controller: 'gaku/students/external_school_records',
        action: 'update',
        student_id: '1',
        id: '1'
      )
    end
  end

  describe 'collection' do
    it 'routes to #new' do
      expect(get: '/students/1/external_school_records/new').to route_to(
        controller: 'gaku/students/external_school_records',
        action: 'new',
        student_id: '1'
      )
    end

    it 'routes to #create' do
      expect(post: '/students/1/external_school_records').to route_to(
        controller: 'gaku/students/external_school_records',
        action: 'create',
        student_id: '1'
      )
    end

    it 'routes to #index' do
      expect(get: '/students/1/external_school_records').to route_to(
        controller: 'gaku/students/external_school_records',
        action: 'index',
        student_id: '1'
      )
    end
  end

end
