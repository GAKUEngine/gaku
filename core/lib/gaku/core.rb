require 'rails/all'
require 'rails/generators'
require 'rails-i18n'
require 'deface'
require 'paperclip'
require 'ransack'
require 'jquery-rails'
require 'devise'
require 'cancan'
require 'inherited_resources'
require 'slim-rails'
require 'kaminari'
require 'client_side_validations'
require 'spreadsheet'
require 'csv'
require 'sidekiq/web'
require 'paper_trail'
require 'globalize3'
require 'decent_exposure'
require 'thinreports-rails'
require 'bootstrap-sass'
require 'bootstrap-editable-rails'


module Gaku

  module Core
  end

  # Used to configure Gaku.
  #
  # Example:
  #
  #   Gaku.config do |config|
  #     config.site_name = "Gaku site"
  #   end

  def self.config(&block)
    yield(Gaku::Config)
  end
end

require 'gaku/core/delegate_belongs_to'
require 'gaku/core/version'
require 'gaku/core/engine'
require 'generators/gaku/dummy/dummy_generator'
