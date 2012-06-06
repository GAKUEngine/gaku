class CoursesController < ApplicationController
  before_filter :authenticate_user!
  inherit_resources

  actions :show, :new, :create, :update, :edit, :destroy
end