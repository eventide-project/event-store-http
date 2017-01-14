module EventStore
  module HTTP
    module Endpoints
      module Gossip
        class Response
          module Transformer
            def self.json
              JSON
            end

            def self.instance(raw_data)
              response = Response.new

              SetAttributes.(response, raw_data)

              raw_data[:members].each do |member_data|
                member = member_instance member_data

                response.add_member member
              end

              response
            end

            def self.member_instance(member_data)
              member = Response::Member.new

              SetAttributes.(
                member,
                member_data,
                strict: true
              )

              member
            end

            module JSON
              def self.read(text)
                formatted_data = ::JSON.parse text, symbolize_names: true

                raw_data = Casing::Underscore.(formatted_data)

                raw_data
              end
            end
          end
        end
      end
    end
  end
end
