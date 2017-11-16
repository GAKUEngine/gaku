module Gaku
  class Container
    attr_accessor :command

    def initialize(command)
      require 'pry';binding.pry
      @command = command
    end

    def execute
      system(resolve_command)
    end

    private

    def resolve_command
      case command
      when 'start'
        'docker-compose up'
      when 'console'
        'docker-compose exec web bundle exec rails console'
      when 'shell'
        'docker-compose exec web bundle exec /bin/bash'
      when 'sample'
        'docker-compose exec  web bundle exec rake db:sample'
      when 'detach'
        'docker-compose up -d'
      end
    end

  end
end
