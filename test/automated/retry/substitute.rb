require_relative '../automated_init'

context "Retry Substitute" do
  context "Error is not specified" do
    substitute = SubstAttr::Substitute.build EventStore::HTTP::Retry

    return_value = substitute.() do
      :some_value
    end

    test "Return value is that of block" do
      assert return_value == :some_value
    end
  end

  context "Error is specified" do
    error_cls = Class.new StandardError
    error = error_cls.new

    substitute = SubstAttr::Substitute.build EventStore::HTTP::Retry
    substitute.set_error error

    invocations = 0

    block = proc {
      invocations += 1
      :some_value
    }

    test "Error is raised" do
      assert proc { substitute.(&block) } do
        raises_error? error_cls
      end
    end

    test "Block is retried once" do
      assert invocations == 2
    end

    test "Telemetry is recorded" do
      assert substitute.telemetry_sink do
        recorded_retried? do |record|
          record.data.error == error
        end
      end
    end
  end

  context "Supplied block triggers next retry" do
    invocations = 0

    substitute = SubstAttr::Substitute.build EventStore::HTTP::Retry

    return_value = substitute.() do |_retry, retries|
      invocations += 1
      _retry.next if retries == 0
      :some_value
    end

    test "Return value is that of block" do
      assert return_value == :some_value
    end

    test "Block is retried" do
      assert invocations == 2
    end

    test "Telemetry is recorded" do
      assert substitute.telemetry_sink do
        recorded_retried? do |record|
          record.data.error.instance_of? EventStore::HTTP::Retry::Trigger
        end
      end
    end
  end
end
