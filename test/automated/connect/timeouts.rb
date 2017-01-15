require_relative '../automated_init'

context "Connect, Timeouts" do
  connect = EventStore::HTTP::Connect::Any.build

  context "Keep alive timeout" do
    context "Setting is not specified" do
      connection = connect.()

      test "Value on connection is set to Net::HTTP default (2)" do
        assert connection.keep_alive_timeout == 2
      end
    end

    context "Setting is specified" do
      connect.keep_alive_timeout = 11

      connection = connect.()

      test "Value on connection is set" do
        assert connection.keep_alive_timeout == 11
      end
    end
  end

  context "Open timeout" do
    context "Setting is not specified" do
      connection = connect.()

      test "Value on connection is set to Net::HTTP default (60)" do
        assert connection.open_timeout == 60
      end
    end

    context "Setting is specified" do
      connect.open_timeout = 11

      connection = connect.()

      test "Value on connection is set" do
        assert connection.open_timeout == 11
      end
    end
  end

  context "Read timeout" do
    context "Setting is not specified" do
      connection = connect.()

      test "Value on connection is set to Net::HTTP default (60)" do
        assert connection.read_timeout == 60
      end
    end

    context "Setting is specified" do
      connect.read_timeout = 11

      connection = connect.()

      test "Value on connection is set" do
        assert connection.read_timeout == 11
      end
    end
  end
end

