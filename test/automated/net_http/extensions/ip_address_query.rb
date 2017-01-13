require_relative '../../automated_init'

context "Net::HTTP IP Address Query Extension" do
  net_http = Controls::NetHTTP.example

  context "Extension hasn't been applied" do
    test "No method error is raised" do
      assert proc { net_http.ip_address } do
        raises_error? NoMethodError
      end
    end
  end

  net_http.extend EventStore::HTTP::NetHTTP::Extensions

  context "Connection has not been started" do
    context "IP address is queried" do
      ip_address = net_http.ip_address

      test "Nil is returned" do
        assert ip_address == nil
      end
    end

    context "Request has been made" do
      net_http.request Controls::NetHTTP::Request.example

      context "IP address is queried" do
        ip_address = net_http.ip_address

        test "Nil is returned" do
          assert ip_address == nil
        end
      end
    end
  end

  context "Connection has been started" do
    net_http.start

    context "IP address is queried" do
      ip_address = net_http.ip_address

      test "IP address is returned" do
        assert ip_address == Controls::IPAddress.example
      end
    end

    net_http.finish
  end
end
