require 'net/http'

require 'configure'; Configure.activate
require 'identifier/uuid'
require 'schema'
require 'settings'; Settings.activate
require 'transform'

require 'event_store/http/log'
require 'event_store/http/settings'
require 'event_store/http/settings/read'

require 'event_store/http/net_http'
require 'event_store/http/net_http/extensions'
require 'event_store/http/net_http/substitute'

require 'event_store/http/connect'
require 'event_store/http/connect/defaults'
require 'event_store/http/connect/leader'

require 'event_store/http/request'

require 'event_store/http/info'
require 'event_store/http/info/response'
require 'event_store/http/info/response/states'
require 'event_store/http/info/response/transformer'

require 'event_store/http/gossip'
require 'event_store/http/gossip/response/member'
require 'event_store/http/gossip/response'
require 'event_store/http/gossip/response/states'
require 'event_store/http/gossip/response/transformer'

require 'event_store/http/retry'
require 'event_store/http/retry/substitute'
require 'event_store/http/retry/telemetry'

require 'event_store/http/session'
require 'event_store/http/session/any_member'
require 'event_store/http/session/defaults'
require 'event_store/http/session/factory'
require 'event_store/http/session/leader'
require 'event_store/http/session/log_text'
require 'event_store/http/session/read'

require 'event_store/http/media_types/events'
require 'event_store/http/media_types/events/data'
require 'event_store/http/media_types/events/serialization'

require 'event_store/http/write'
require 'event_store/http/write/log_text'

EventStore::HTTP::NetHTTP.activate
