# See http://github.com/ryanb/cancan for more details on cancan.
require 'cancancan'

module Gaku
  class Ability
    include CanCan::Ability

    def initialize(user)
      if user.role?('admin')
        can :manage, :all
      elsif user.role?('teacher')
        can :manage, Gaku::Syllabus, syllabus_teachers: { teacher_id: user.teacher.id }
        can :create, Gaku::Syllabus
      else
        # NOTE: to be added
      end
    end
  end
end
