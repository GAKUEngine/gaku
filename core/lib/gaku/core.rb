require 'rails/all'
require 'rails/generators'
require 'rails-i18n'
require 'slim'
require 'eco'
require 'paperclip'
require 'ransack'
require 'jquery-rails'
require 'jquery-ui-rails'
require 'turbolinks'
require 'devise'
require 'cancan'
require 'inherited_resources'
require 'draper'
require 'kaminari'
require 'rails4_client_side_validations'
require 'sidekiq/web'
require 'paper_trail'
require 'globalize3'
require 'thinreports-rails'
require 'bootstrap-sass'
require 'nested_form'
require 'gaku_helpers'
require 'gaku_forms'
require 'gaku_nested_forms'


module Gaku

  module Core
  end

  def self.config(&block)
    yield(Gaku::Config)
  end
end

require 'gaku/core/version'
require 'gaku/core/engine'
require 'generators/gaku/dummy/dummy_generator'
