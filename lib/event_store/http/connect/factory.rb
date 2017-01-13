module EventStore
  module HTTP
    module Connect
      class Factory
        include Log::Dependency

        initializer :settings, :namespace

        attr_writer :type

        def type
          @type ||= get_type
        end

        def self.build(settings=nil, namespace: nil, type: nil)
          settings ||= Settings.instance
          namespace = Array(namespace)

          instance = new settings, namespace
          instance.type = type unless type.nil?
          instance
        end

        def self.call(settings=nil, **arguments)
          instance = build settings, **arguments
          instance.()
        end

        def call
          logger.trace { "Constructing Connect (Type: #{type.inspect})" }

          cls = resolve_class

          instance = cls.new

          settings.set instance, namespace

          instance.configure

          logger.debug { "Connect constructed (Type: #{type.inspect}, Class: #{instance.class})" }

          instance
        end

        def get_type
          type = settings.get :type, namespace
          type ||= Defaults.type
          type.to_sym
        end

        def resolve_class
          self.class.types.fetch type do
            error_message = "Unknown type (Type: #{type.inspect}, KnownTypes: #{self.class.types.keys.inspect})"
            logger.error { error_message }
            raise UnknownType, error_message
          end
        end

        def self.types
          @types ||= {
            :any => Any,
            :leader => Leader
          }
        end

        UnknownType = Class.new StandardError
      end
    end
  end
end
