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
    error = Class.new StandardError

    context "Retry limit is not set" do
      substitute = SubstAttr::Substitute.build EventStore::HTTP::Retry
      substitute.set_error error

      invocations = 0

      return_value = substitute.() do
        invocations += 1
        :some_value
      end

      test "Return value is that of block" do
        assert return_value == :some_value
      end

      test "Block is retried once" do
        assert invocations == 2
      end

      test "Telemetry is recorded" do
        assert substitute.telemetry_sink do
          recorded_retried? do |record|
            record.data.error.instance_of? error
          end
        end
      end
    end

    context "Retry limit is set to zero" do
      substitute = SubstAttr::Substitute.build EventStore::HTTP::Retry
      substitute.retry_limit = 0
      substitute.set_error error

      blk = proc { }

      test "Error is raised" do
        assert proc { substitute.(&blk) } do
          raises_error? error
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
