module EventStore
  module HTTP
    module Controls
      module JSON
        def self.data
          {
            :some_attr1 => 'value1',
            :some_attr2 => {
              :some_attr3 => 'value2'
            }
          }
        end

        def self.text
          <<~JSON.chomp
          {
            "someAttr1": "value1",
            "someAttr2": {
              "someAttr3": "value2"
            }
          }
          JSON
        end
      end
    end
  end
end
