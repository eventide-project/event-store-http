module EventStore
  module HTTP
    class Settings
      module Read
        def self.instance
          @instance ||= get
        end

        def self.get(settings=nil, namespace: nil)
          settings ||= Settings.instance
          namespace = Array(namespace)

          read_settings_data = settings.get *namespace, :read
          read_settings_data ||= {}

          settings_data = settings.get *namespace

          merged_data = settings_data.merge read_settings_data

          ::Settings.build merged_data
        end

        def self.settings_namespace
          :read
        end
      end
    end
  end
end
