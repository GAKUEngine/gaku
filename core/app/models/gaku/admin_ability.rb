require 'cancan'

module Gaku
  class AdminAbility
    include CanCan::Ability

    def initialize(user)
      clear_aliased_actions

      alias_action :edit, to: :update
      alias_action :new, to: :create
      alias_action :new_action, to: :create
      alias_action :show, to: :read

      user ||= User.new

      can :manage, :all if user.role? :admin
    end
  end
end
