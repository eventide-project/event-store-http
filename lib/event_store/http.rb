require 'net/http'

require 'configure'; Configure.activate
require 'identifier/uuid'
require 'schema'
require 'settings'; Settings.activate
require 'transform'

require 'event_store/http/log'
require 'event_store/http/settings'

require 'event_store/http/net_http'
require 'event_store/http/net_http/extensions'
require 'event_store/http/net_http/substitute'

require 'event_store/http/connect'
require 'event_store/http/connect/any'
require 'event_store/http/connect/defaults'
require 'event_store/http/connect/factory'
require 'event_store/http/connect/leader'

require 'event_store/http/endpoints/info/get'
require 'event_store/http/endpoints/info/response'
require 'event_store/http/endpoints/info/response/states'
require 'event_store/http/endpoints/info/response/transformer'

require 'event_store/http/endpoints/gossip/get'
require 'event_store/http/endpoints/gossip/response/member'
require 'event_store/http/endpoints/gossip/response'
require 'event_store/http/endpoints/gossip/response/states'
require 'event_store/http/endpoints/gossip/response/transformer'

require 'event_store/http/retry'
require 'event_store/http/retry/substitute'
require 'event_store/http/retry/telemetry'

require 'event_store/http/session'
require 'event_store/http/session/log_text'

EventStore::HTTP::NetHTTP.activate
