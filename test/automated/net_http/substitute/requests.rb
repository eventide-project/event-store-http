require_relative '../../automated_init'

context "Net::HTTP Substitute, Sending Requests" do
  substitute = SubstAttr::Substitute.build Net::HTTP

  %w(Get Post Put Delete).each do |action|
    context "#{action} request is made" do
      request_cls = Net::HTTP.const_get action
      request = request_cls.new '/some-path'

      context do
        substitute = SubstAttr::Substitute.build Net::HTTP
        substitute.set_response 299

        response = substitute.request request

        test "Response is successful" do
          assert response.is_a?(Net::HTTPSuccess)
        end
      end

      context "Redirect response is specified" do
        substitute = SubstAttr::Substitute.build Net::HTTP
        substitute.set_response 399

        response = substitute.request request

        test "Response is a redirect" do
          assert response.is_a?(Net::HTTPRedirection)
        end
      end

      context "Client error response is specified" do
        substitute = SubstAttr::Substitute.build Net::HTTP
        substitute.set_response 499

        response = substitute.request request

        test "Response is a client error" do
          assert response.is_a?(Net::HTTPClientError)
        end
      end

      context "Server error response is specified" do
        substitute = SubstAttr::Substitute.build Net::HTTP
        substitute.set_response 599

        response = substitute.request request

        test "Response is a client error" do
          assert response.is_a?(Net::HTTPServerError)
        end
      end
    end
  end

  context "Response includes headers" do
    substitute = SubstAttr::Substitute.build Net::HTTP
    substitute.set_response 200, headers: { 'Some-Header' => 'some-value' }

    request = Controls::NetHTTP::Request.example

    response = substitute.request request

    context "Response header" do
      test do
        assert response['Some-Header'] == 'some-value'
      end

      test "Header name casing differs" do
        assert response['some-header'] == 'some-value'
      end
    end
  end

  context "Response includes body" do
    substitute = SubstAttr::Substitute.build Net::HTTP
    substitute.set_response 200, body: 'some-body'

    request = Controls::NetHTTP::Request.example

    response = substitute.request request

    test "Body is returned" do
      assert response.body == 'some-body'
    end
  end

  context "Multiple responses are set" do
    substitute = SubstAttr::Substitute.build Net::HTTP

    substitute.set_response 200
    substitute.set_response 201

    request = Controls::NetHTTP::Request.example

    context "First request is made" do
      response = substitute.request request

      test "First response set is returned" do
        assert response.code == '200'
      end
    end

    context "Second request is made" do
      response = substitute.request request

      test "Second response set is returned" do
        assert response.code == '201'
      end
    end

    context "All responses have been returned" do
      response = substitute.request request

      test "404 is returned" do
        assert response.code == '404'
      end

      test "Reason phrase" do
        assert response.message == 'None'
      end

      test "Body is empty" do
        assert response.body == ''
      end
    end
  end

  context "Error is set" do
    error = Class.new StandardError

    substitute = SubstAttr::Substitute.build Net::HTTP
    substitute.set_error error

    request = Controls::NetHTTP::Request.example

    context "Request is made" do
      test "Error is raised" do
        assert proc { substitute.request request } do
          raises_error? error
        end
      end
    end
  end
end
