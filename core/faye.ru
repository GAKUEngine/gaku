require 'faye'
Faye::WebSocket.load_adapter('thin')

Faye.logger = ->(m) { puts m }

faye_server = Faye::RackAdapter.new(mount: '/faye', timeout: 45)
run faye_server
