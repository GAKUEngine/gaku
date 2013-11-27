require 'rails/all'
require 'rails/generators'
require 'rails-i18n'
require 'paperclip'
require 'ransack'

require 'devise'
require 'cancan'
require 'kaminari'
require 'paper_trail'
require 'globalize'
require 'responders'

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
