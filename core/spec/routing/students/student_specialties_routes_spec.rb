require 'spec_helper'

describe Gaku::Students::StudentSpecialtiesController do

  routes { Gaku::Core::Engine.routes }

  describe 'member' do
    it 'routes to #edit' do
      expect(get: '/students/1/student_specialties/1/edit').to route_to(
        controller: 'gaku/students/student_specialties',
        action: 'edit',
        student_id: '1',
        id: '1'
      )
    end

    it 'routes to #destroy' do
      expect(delete: '/students/1/student_specialties/1').to route_to(
        controller: 'gaku/students/student_specialties',
        action: 'destroy',
        student_id: '1',
        id: '1'
      )
    end

    it 'routes to #update' do
      expect(patch: '/students/1/student_specialties/1').to route_to(
        controller: 'gaku/students/student_specialties',
        action: 'update',
        student_id: '1',
        id: '1'
      )
    end
  end

  describe 'collection' do
    it 'routes to #new' do
      expect(get: '/students/1/student_specialties/new').to route_to(
        controller: 'gaku/students/student_specialties',
        action: 'new',
        student_id: '1'
      )
    end

    it 'routes to #create' do
      expect(post: '/students/1/student_specialties').to route_to(
        controller: 'gaku/students/student_specialties',
        action: 'create',
        student_id: '1'
      )
    end


    it 'routes to #index' do
      expect(get: '/students/1/student_specialties').to route_to(
        controller: 'gaku/students/student_specialties',
        action: 'index',
        student_id: '1'
      )
    end
  end

end