module Gaku
  class Container
    attr_accessor :command

    def initialize(command)
      @command = command
    end

    def execute
      system("#{goto_root_dir};#{resolve_command}")
    end

    private

    def goto_root_dir
      "cd #{__dir__}/../../"
    end

    def resolve_command
      case command
      when 'start'
        "docker-compose up -d"
      when 'stop'
        'docker-compose down'
      when 'delete'
        'docker-compose down -v'
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
