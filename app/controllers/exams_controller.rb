class ExamsController < ApplicationController
  inherit_resources

  actions :show, :new, :create, :update, :edit, :destroy
end