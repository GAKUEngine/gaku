require 'faraday'

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
      wait_for_container
      _exe 'docker-compose exec web bundle exec rails console'
    end

    def self.Terminal
      wait_for_container
      _exe 'docker-compose exec web bundle exec /bin/bash'
    end

    def self.Sample
      wait_for_container
      _exe 'docker-compose run web bundle exec rake db:migrate db:sample[simple]'
    end

    def self.Detach
      _exe 'docker-compose up -d'
    end

    def self.Testing
      wait_for_container
      _exe 'docker-compose exec web bundle exec rake testing:env_setup'
    end

    def self._goto_root_dir
      "cd #{__dir__}/../../"
    end

    def self._exe(command)
      system("#{_goto_root_dir} && #{command}")
    end

    def self.wait_for_container
      loop do
        break if self.container_running?
        puts '⏱ Waiting for server instance...'
        sleep 5
      end
    end

    def self.container_running?
      res = Faraday.get('http://localhost:9000/api/v1/status')
      if res && res.status == 200
        puts '🆗 Received response from test container.'
        return true
      end
    rescue
      false
    end
  end
end
