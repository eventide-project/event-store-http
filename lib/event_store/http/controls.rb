require 'erb'
require 'resolv'
require 'tempfile'

require 'clock/controls'
require 'identifier/uuid/controls'

require 'event_store/http/controls/time'
require 'event_store/http/controls/uuid'

require 'event_store/http/controls/hostname'
require 'event_store/http/controls/hostname/resolution'
require 'event_store/http/controls/hostname/cluster'
require 'event_store/http/controls/ip_address'
require 'event_store/http/controls/ip_address/cluster'
require 'event_store/http/controls/port'

require 'event_store/http/controls/net_http'
require 'event_store/http/controls/net_http/host_header'
require 'event_store/http/controls/net_http/request'

require 'event_store/http/controls/cluster/size'
require 'event_store/http/controls/cluster/current_members'

require 'event_store/http/controls/connection_type'

require 'event_store/http/controls/endpoints/gossip/response'
require 'event_store/http/controls/endpoints/gossip/response/member'
