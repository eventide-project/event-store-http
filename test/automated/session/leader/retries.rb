require_relative '../../automated_init'

context "Leader Session Retries Failed Request" do
  leader_ip_address, follower_ip_address, * = Controls::Cluster::CurrentMembers.get

  settings = Settings.build({
    :host => Controls::Hostname::Cluster.example,
    :retry_duration => 0,
    :retry_limit => 1
  })
  session = EventStore::HTTP::Session.build settings, type: :leader

  net_http = SubstAttr::Substitute.build Net::HTTP
  net_http.request_headers['Host'] = "#{follower_ip_address}:#{Controls::Port.example}"
  net_http.request_headers['Connection'] = 'close'
  net_http.set_error IOError

  session.net_http = net_http

  request = Controls::NetHTTP::Request.example

  context "Request is performed" do
    response = session.request request

    test "Request is successful upon retrying" do
      assert Net::HTTPSuccess === response
    end

    test "Host header is changed to match leader" do
      assert request['Host'] == "#{leader_ip_address}:#{Controls::Port.example}"
    end

    test "Connection header is unset" do
      assert request['Connection'].nil?
    end
  end
end
