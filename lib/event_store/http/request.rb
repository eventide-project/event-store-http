module EventStore
  module HTTP
    module Request
      def self.included(cls)
        cls.class_exec do
          dependency :connection, Net::HTTP

          extend Build
          extend Call
        end
      end

      Virtual::Method.define self, :call

      Virtual::Method.define self, :configure do |session: nil|
      end

      module Build
        def build(connection: nil, session: nil)
          instance = new

          if session.nil?
            Connect.configure_connection instance, connection: connection
          elsif !connection.nil?
            raise ArgumentError, "Cannot specify both connection and session"
          else
            instance.connection = session
          end

          instance.configure(session: session)
          instance
        end
      end

      module Call
        def call(*arguments, connection: nil, session: nil, **keyword_arguments)
          instance = build connection: connection, session: session

          if keyword_arguments.empty?
            instance.(*arguments)
          else
            instance.(*arguments, **keyword_arguments)
          end
        end
      end

      module Assertions
        def session?(session, strict: nil)
          return false unless connection.is_a? Session
          return false unless connection.connect == session.connect

          if strict
            connection.equal? session
          else
            true
          end
        end
      end
    end
  end
end
