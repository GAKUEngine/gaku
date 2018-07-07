module Gaku
  class Container
    def self.Start
      _exe 'docker-compose up -d'
    end

    def self.Stop
      _exe 'docker-compose down'
    end

    def self.Delete
      _exe 'docker-compose down -v'
    end

    def self.Console
      _exe 'docker-compose exec web bundle exec rails console'
    end

    def self.Terminal
      _exe 'docker-compose exec web bundle exec /bin/bash'
    end

    def self.Sample
      _exe 'docker-compose exec web bundle exec rake db:sample[simple]'
    end

    def self.Detach
      _exe 'docker-compose up -d'
    end

    def self.Testing
      _exe 'docker-compose exec web bundle exec rake testing:env_setup'
    end

    def self._goto_root_dir
      "cd #{__dir__}/../../"
    end

    def self._exe(command)
      `#{_goto_root_dir} && #{command}`
    end
  end
end
