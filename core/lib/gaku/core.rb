require 'rails/all'
require 'rails/generators'
require 'rails-i18n'
require 'slim'
require 'eco'
require 'paperclip'
require 'ransack'
require 'jquery-rails'
require 'jquery-ui-rails'
require 'jquery-minicolors-rails'
require 'momentjs-rails'
require 'underscore-rails'
require 'turbolinks'
require 'nprogress-rails'
require 'devise'
require 'cancan'
require 'responders'
require 'inherited_resources'
require 'draper'
require 'kaminari'
require 'rails4_client_side_validations'
require 'paper_trail'
require 'globalize'
require 'sass'
require 'bootstrap-sass'
require 'bootstrap-datepicker-rails'
require 'nested_form'
require 'phantom_helpers'
require 'phantom_forms'
require 'phantom_nested_forms'

require 'thinreports-rails'

module Gaku

  module Core
  end

  def self.config(&block)
    yield(Gaku::Config)
  end
end

require 'gaku/core/version'
require 'gaku/core/engine'
require 'gaku/core/console_colors'
require 'generators/gaku/dummy/dummy_generator'
