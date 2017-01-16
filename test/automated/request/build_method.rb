require_relative '../automated_init'

context "Request Build Method" do
  cls = Class.new do
    include EventStore::HTTP::Request

    attr_accessor :configured
    attr_accessor :session

    def configure(session: nil)
      self.configured = true
      self.session = session
    end
  end

  context "Neither connection nor session are specified" do
    request = cls.build

    test "Connection dependency is configured as a raw HTTP connection" do
      assert request.connection.instance_of?(Net::HTTP)
    end

    test "Specialized configuration is invoked" do
      assert request.configured
    end
  end

  context "Connection is specified" do
    request = cls.build connection: :some_connection

    test "Connection dependency is set to that specified" do
      assert request.connection == :some_connection
    end

    test "Session is not available to specialized configuration" do
      assert request.session.nil?
    end
  end

  context "Session is specified" do
    request = cls.build session: :some_session

    test "Connection dependency is set to that specified" do
      assert request.connection == :some_session
    end

    test "Session is available to specialized configuration" do
      assert request.session == :some_session
    end
  end

  context "Both session and connection are specified" do
    test "Agument error is raised" do
      assert proc { cls.build session: :some_session, connection: :some_connection } do
        raises_error? ArgumentError
      end
    end
  end
end
