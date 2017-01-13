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
              leader_ip_address, *follower_ip_addresses = Controls::Cluster::CurrentMembers.get

              ERB.new(<<~ERB, 0, '>').result binding
              <%= IPAddress::Available.example %> <%= Hostname::Available.example %>\n
              <%= IPAddress::Available.example %> <%= Hostname::Available::Other.example %>\n
              <%= IPAddress::Unavailable.example %> <%= Hostname::Unavailable.example %>\n

              <% (1..Controls::Cluster::Size.example).each do |member_index| %>
              <%= IPAddress::Cluster::Available.example member_index %> <%= Hostname::Cluster::Available.example %>\n
              <%= IPAddress::Cluster::Available.example member_index %> <%= Hostname::Cluster::Available::Member.example member_index %>\n
              <% end %>

              <% (1..Controls::Cluster::Size.example).each do |member_index| %>
              <%= IPAddress::Cluster::Unavailable.example member_index %> <%= Hostname::Cluster::Unavailable.example %>\n
              <%= IPAddress::Cluster::Unavailable.example member_index %> <%= Hostname::Cluster::Unavailable::Member.example member_index %>\n
              <% end %>

              <% (1..Controls::Cluster::Size.example).each do |member_index| %>
              <%= IPAddress::Cluster::PartiallyAvailable.example member_index %> <%= Hostname::Cluster::PartiallyAvailable.example %>\n
              <%= IPAddress::Cluster::PartiallyAvailable.example member_index %> <%= Hostname::Cluster::PartiallyAvailable::Member.example member_index %>\n
              <% end %>

              <%= leader_ip_address %> <%= Hostname::Cluster::Leader.example %>\n
              <% follower_ip_addresses.each do |follower_ip_address| %>
              <%= follower_ip_address %> <%= Hostname::Cluster::Followers.example %>\n
              <% end %>
              ERB
            end
          end
        end
      end
    end
  end
end
