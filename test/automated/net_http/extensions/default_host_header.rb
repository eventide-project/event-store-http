require_relative '../../automated_init'

context "Net::HTTP Default Host Header Extension" do
  net_http = Controls::NetHTTP.example

  context "Extension hasn't been applied" do
    context "Request is performed" do
      request = Controls::NetHTTP::Request.example

      net_http.request request

      test "Host header uses hostname" do
        assert request['host'] == Controls::NetHTTP::HostHeader::Hostname.example
      end
    end
  end

  net_http.extend EventStore::HTTP::NetHTTP::Extensions

  context "Request is performed" do
    context "Host is not set on request" do
      request = Controls::NetHTTP::Request.example

      net_http.request request

      test "Host header uses IP address" do
        assert request['host'] == Controls::NetHTTP::HostHeader::IPAddress.example
      end
    end

    context "Host is set on request" do
      host_header = Controls::NetHTTP::HostHeader::Other.example

      request = Controls::NetHTTP::Request.example
      request['host'] = host_header

      net_http.request request

      test "Host header uses IP address" do
        assert request['host'] == host_header
      end
    end
  end
end
