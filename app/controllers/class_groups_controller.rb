class ClassGroupsController < ApplicationController
  inherit_resources

  actions :index, :show, :new, :create, :update, :edit, :destroy
end
