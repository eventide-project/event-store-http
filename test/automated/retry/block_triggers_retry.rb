require_relative '../automated_init'

context "Supplied Block Triggers Retry" do
  _retry = EventStore::HTTP::Retry.build
  _retry.retry_duration = 0

  telemetry_sink = EventStore::HTTP::Retry.register_telemetry_sink _retry

  invocations = 0

  return_value = _retry.() do |_retry, retries|
    invocations += 1

    _retry.next if retries == 0

    :some_value
  end

  test "Return value is that of block" do
    assert return_value == :some_value
  end

  test "Block is invoked again" do
    assert invocations == 2
  end

  test "Trigger error is used to induce retry" do
    assert telemetry_sink do
      recorded_retried? do |record|
        record.data.error.instance_of? EventStore::HTTP::Retry::Trigger
      end
    end
  end
end
