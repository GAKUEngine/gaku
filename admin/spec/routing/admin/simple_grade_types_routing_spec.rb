require 'spec_helper_routing'

describe Gaku::Admin::SimpleGradeTypesController do

  routes { Gaku::Core::Engine.routes }

  describe 'member' do

    it 'routes to #edit' do
      expect(get: 'admin/simple_grade_types/1/edit').to route_to(
        controller: 'gaku/admin/simple_grade_types',
        action: 'edit',
        id: '1'
      )
    end

    it 'routes to #destroy' do
      expect(delete: 'admin/simple_grade_types/1').to route_to(
        controller: 'gaku/admin/simple_grade_types',
        action: 'destroy',
        id: '1'
      )
    end
  end

  describe 'collection' do


    it 'routes to #index' do
      expect(get: 'admin/simple_grade_types/').to route_to(
        controller: 'gaku/admin/simple_grade_types',
        action: 'index'
      )
    end

    it 'routes to #new' do
      expect(get: 'admin/simple_grade_types/new').to route_to(
        controller: 'gaku/admin/simple_grade_types',
        action: 'new'
      )
    end

    it 'routes to #create' do
      expect(post: 'admin/simple_grade_types').to route_to(
        controller: 'gaku/admin/simple_grade_types',
        action: 'create'
      )
    end

  end

end
