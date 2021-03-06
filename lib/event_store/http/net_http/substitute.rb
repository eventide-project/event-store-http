module EventStore
  module HTTP
    module NetHTTP
      class Substitute
        initializer :telemetry_sink

        attr_accessor :active
        attr_accessor :error

        def active?
          @active.nil? ? false : @active
        end

        dependency :telemetry, ::Telemetry

        def self.build
          telemetry_sink = Telemetry::Sink.new

          instance = new telemetry_sink

          telemetry = ::Telemetry.configure instance
          telemetry.register telemetry_sink

          instance
        end

        def request(request, _=nil, &block)
          telemetry.record :requested, Telemetry::Requested.new(request)

          request_headers.each do |name, value|
            request[name] = value
          end

          raise error if error

          response = next_response

          telemetry.record :responded, Telemetry::Responded.new(response, request)

          response
        end

        def set_error(error)
          self.error = error
        end

        def set_response(*arguments)
          response = build_response *arguments

          responses << response

          response
        end

        def next_response
          return build_response 404 if responses.empty?

          response = responses.shift

          responses << response if responses.empty?

          response
        end

        def responses
          @responses ||= []
        end

        def build_response(status_code, reason_phrase: nil, body: nil, headers: nil)
          reason_phrase ||= 'None'
          headers ||= {}
          body ||= ''

          response_cls = Net::HTTPResponse::CODE_TO_OBJ.fetch status_code.to_s do
            case status_code
            when (200...300) then Net::HTTPSuccess
            when (300...400) then Net::HTTPRedirection
            when (400...500) then Net::HTTPClientError
            when (500...600) then Net::HTTPServerError
            end
          end

          response = response_cls.new '1.1', status_code.to_s, reason_phrase

          headers.each do |name, value|
            response[name] = value
          end

          response.instance_exec do
            @read = true
            @body = body
          end

          response
        end

        def request_headers
          @request_headers ||= {}
        end

        def start
          self.active = true
        end

        def finish
          self.active = false
        end
      end
    end
  end
end

