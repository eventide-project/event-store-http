module EventStore
  module HTTP
    module JSON
      module Deserialize
        def self.call(text)
          ::JSON.parse text, object_class: ObjectClass
        end

        class ObjectClass < Hash
          def []=(raw_key, value)
            key = key_cache[raw_key]

            super key, value
          end

          def key_cache
            @@key_cache ||= Hash.new do |cache, raw_key|
              cache[raw_key] = Casing::Underscore.(raw_key).to_sym
            end
          end
        end
      end
    end
  end
end
