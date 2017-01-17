require_relative '../../automated_init'

context "Net::HTTP Substitute Telemetry" do
  substitute = SubstAttr::Substitute.build Net::HTTP

  response = substitute.set_response 200

  request = Controls::NetHTTP::Request.example

  substitute.request request

  test "Requested record" do
    assert substitute.telemetry_sink do
      recorded_requested? do |record|
        record.data.request == request
      end
    end
  end

  test "Responded record" do
    assert substitute.telemetry_sink do
      recorded_responded? do |record|
        record.data.response == response && record.data.request == request
      end
    end
  end
end
