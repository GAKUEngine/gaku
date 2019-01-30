module Gaku
  module Api
    class Engine < ::Rails::Engine
      engine_name 'gaku_api'
      config.generators.api_only = true

      initializer 'actionpack-msgpack_parser.configure' do
        ActionDispatch::Request.parameter_parsers[:msgpack] = -> (raw_post) do
          ActiveSupport::MessagePack.decode(raw_post) || {}
        end
      end

      config.after_initialize do
        ActionController.add_renderer :msgpack do |resource, options|
          MessagePack::DefaultFactory.register_type(0x00, Symbol)
          resource_serializer = ActiveModelSerializers::SerializableResource.new(resource, options)
          self.content_type = Mime[:msgpack]
          if resource_serializer.serializer?
            self.response_body = resource_serializer.serializable_hash.to_msgpack
          else
            self.response_body = resource.to_msgpack
          end
        end
      end

    end
  end
end
