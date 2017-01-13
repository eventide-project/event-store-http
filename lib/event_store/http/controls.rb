require 'erb'
require 'resolv'
require 'tempfile'

require 'event_store/http/controls/hostname'
require 'event_store/http/controls/hostname/resolution'
require 'event_store/http/controls/hostname/cluster'
require 'event_store/http/controls/ip_address'
require 'event_store/http/controls/ip_address/cluster'
require 'event_store/http/controls/port'

require 'event_store/http/controls/connection_type'
require 'event_store/http/controls/cluster/size'
require 'event_store/http/controls/cluster/current_members'
