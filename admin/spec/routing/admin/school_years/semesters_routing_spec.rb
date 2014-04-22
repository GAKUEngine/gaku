require 'spec_helper_routing'

describe Gaku::Admin::SchoolYears::SemestersController do

  routes { Gaku::Core::Engine.routes }

  describe 'member' do

    it 'routes to #edit' do
      expect(get: 'admin/school_years/1/semesters/1/edit').to route_to(
        controller: 'gaku/admin/school_years/semesters',
        action: 'edit',
        school_year_id: '1',
        id: '1'
      )
    end

    it 'routes to #update' do
      expect(patch: 'admin/school_years/1/semesters/1').to route_to(
        controller: 'gaku/admin/school_years/semesters',
        action: 'update',
        school_year_id: '1',
        id: '1'
      )
    end

    it 'routes to #destroy' do
      expect(delete: 'admin/school_years/1/semesters/1').to route_to(
        controller: 'gaku/admin/school_years/semesters',
        action: 'destroy',
        school_year_id: '1',
        id: '1'
      )
    end
  end

  describe 'collection' do

    it 'routes to #new' do
      expect(get: 'admin/school_years/1/semesters/new').to route_to(
        controller: 'gaku/admin/school_years/semesters',
        action: 'new',
        school_year_id: '1'
      )
    end

    it 'routes to #create' do
      expect(post: 'admin/school_years/1/semesters').to route_to(
        controller: 'gaku/admin/school_years/semesters',
        action: 'create',
        school_year_id: '1'
      )
    end

  end

end
