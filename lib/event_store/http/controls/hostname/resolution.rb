module EventStore
  module HTTP
    module Controls
      module Hostname
        module Resolution
          def self.activate
            require 'resolv-replace'

            hosts_path = HostsFile.get

            hosts_resolver = Resolv::Hosts.new hosts_path

            Resolv::DefaultResolver.replace_resolvers [hosts_resolver]
          end

          module HostsFile
            def self.get
              tempfile = Tempfile.new 'hosts'
              tempfile.write text
              tempfile.close

              at_exit { tempfile.unlink }

              tempfile.path
            end

            def self.text
              ERB.new(<<~ERB, 0, '>').result binding
              <%= IPAddress::Available.example %> <%= Hostname::Available.example %>\n
              <%= IPAddress::Unavailable.example %> <%= Hostname::Unavailable.example %>\n

              <% (1..Controls::Cluster::Size.example).each do |member_index| %>
              <%= IPAddress::Cluster::Available.example member_index %> <%= Hostname::Cluster::Available.example %>\n
              <% end %>

              <% (1..Controls::Cluster::Size.example).each do |member_index| %>
              <%= IPAddress::Cluster::Unavailable.example member_index %> <%= Hostname::Cluster::Unavailable.example %>\n
              <% end %>

              <% (1..Controls::Cluster::Size.example).each do |member_index| %>
              <%= IPAddress::Cluster::PartiallyAvailable.example member_index %> <%= Hostname::Cluster::PartiallyAvailable.example %>\n
              <% end %>
              ERB
            end
          end
        end
      end
    end
  end
end
