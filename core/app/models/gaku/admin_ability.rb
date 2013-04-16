# Implementation class for Cancan gem.  Instead of overriding this class, consider adding new permissions
# using the special +register_ability+ method which allows extensions to add their own abilities.
#
# See http://github.com/ryanb/cancan for more details on cancan.
require 'cancan'

module Gaku
  class AdminAbility
    include CanCan::Ability

    def initialize(user)
      self.clear_aliased_actions

      # override cancan default aliasing (we don't want to differentiate between read and index)
      alias_action :edit, :to => :update
      alias_action :new, :to => :create
      alias_action :new_action, :to => :create
      alias_action :show, :to => :read

      user ||= User.new

      if user.role? :admin
        can :manage, :all
      end

    end
  end
end
