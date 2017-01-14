module EventStore
  module HTTP
    module Controls
      module Port
        def self.example
          2113
        end

        module Internal
          def self.example
            2112
          end
        end

        module TCP
          def self.example
            1113
          end

          module Internal
            def self.example
              1112
            end
          end
        end
      end
    end
  end
end
